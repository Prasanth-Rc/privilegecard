package com.privilegecard.privilegecard.security;

import com.privilegecard.privilegecard.entity.LoginUser;
import com.privilegecard.privilegecard.repository.LoginUserRepository;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ErpUserDetailsService implements UserDetailsService {

    private final LoginUserRepository loginUserRepository;

    public ErpUserDetailsService(LoginUserRepository loginUserRepository) {
        this.loginUserRepository = loginUserRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String username)
            throws UsernameNotFoundException {

        LoginUser user = loginUserRepository.findByAlias(username);

        if (user == null) {
            throw new UsernameNotFoundException("User not found: " + username);
        }

        String passwordHash = loginUserRepository.findPasswordHashByAlias(username);
        if (passwordHash == null) {
            throw new UsernameNotFoundException("No password for: " + username);
        }

        return User.withUsername(user.getAliasName())
                .password(passwordHash)                 // stored hash
                .authorities(List.of(new SimpleGrantedAuthority("ROLE_USER")))
                .accountExpired(false)
                .accountLocked(false)
                .credentialsExpired(false)
                .disabled(false)
                .build();
    }
}