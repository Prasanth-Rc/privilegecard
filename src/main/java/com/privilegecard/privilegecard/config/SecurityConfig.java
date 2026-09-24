package com.privilegecard.privilegecard.config;

import com.privilegecard.privilegecard.security.ErpAuthSuccessHandler;
import com.privilegecard.privilegecard.security.ErpLogoutHandler;
import com.privilegecard.privilegecard.security.TripleMd5PasswordEncoder;

import jakarta.servlet.DispatcherType;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;
import org.springframework.security.web.servlet.util.matcher.PathPatternRequestMatcher;
import org.springframework.security.web.util.matcher.DispatcherTypeRequestMatcher;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private final ErpAuthSuccessHandler authSuccessHandler;
    private final ErpLogoutHandler logoutHandler;

    public SecurityConfig(ErpAuthSuccessHandler authSuccessHandler,
                          ErpLogoutHandler logoutHandler) {
        this.authSuccessHandler = authSuccessHandler;
        this.logoutHandler = logoutHandler;
    }

    // ------------------------------------------------------------
    // 1) Password encoder (static, so it's created early)
    // ------------------------------------------------------------
    @Bean
    public static PasswordEncoder passwordEncoder() {
        return new TripleMd5PasswordEncoder();
    }

    // ------------------------------------------------------------
    // 2) The DaoAuthenticationProvider goes HERE
    // ------------------------------------------------------------
    @Bean
    public DaoAuthenticationProvider authenticationProvider(UserDetailsService userDetailsService,
                                                            PasswordEncoder passwordEncoder) {
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider(userDetailsService);
        provider.setPasswordEncoder(passwordEncoder);
        return provider;
    }

    // ------------------------------------------------------------
    // 3) Filter chain, now using the provider
    // ------------------------------------------------------------
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http,
                                                   DaoAuthenticationProvider authenticationProvider) throws Exception {

        PathPatternRequestMatcher.Builder matcher = PathPatternRequestMatcher.withDefaults();

        http
                .authenticationProvider(authenticationProvider)

                .securityMatcher(new DispatcherTypeRequestMatcher(DispatcherType.REQUEST))

                .csrf(csrf -> csrf
                        .csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse())
                )

                .headers(headers -> headers
                        .cacheControl(Customizer.withDefaults())    // ← இது போதும்
                )

                .authorizeHttpRequests(auth -> auth
                        .requestMatchers(
                                matcher.matcher("/loginForm"),
                                matcher.matcher("/login"),
                                matcher.matcher("/logout"),
                                matcher.matcher("/css/**"),
                                matcher.matcher("/js/**"),
                                matcher.matcher("/images/**"),
                                matcher.matcher("/fonts/**"),
                                matcher.matcher("/bootstrapcss/**"),
                                matcher.matcher("/bootstrapjs/**"),
                                matcher.matcher("/webjars/**"),
                                matcher.matcher("/favicon.ico"),
                                matcher.matcher("/error")
                        ).permitAll()
                        .anyRequest().authenticated()
                )

                .formLogin(form -> form
                        .loginPage("/loginForm")
                        .loginProcessingUrl("/login")
                        .usernameParameter("username")
                        .passwordParameter("password")
                        .successHandler(authSuccessHandler)
                        .failureUrl("/loginForm?error=true")
                        .permitAll()
                )

                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .addLogoutHandler(logoutHandler)
                        .logoutSuccessUrl("/loginForm")
                        .invalidateHttpSession(true)
                        .clearAuthentication(true)
                        .deleteCookies("JSESSIONID")
                        .permitAll()
                )

                .requestCache(cache -> cache.disable())
                .httpBasic(basic -> basic.disable());

        return http.build();
    }
}