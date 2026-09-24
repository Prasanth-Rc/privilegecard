package com.privilegecard.privilegecard.security;

import com.privilegecard.privilegecard.entity.LoginUser;
import com.privilegecard.privilegecard.service.LoginService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutHandler;
import org.springframework.stereotype.Component;

@Component
public class ErpLogoutHandler implements LogoutHandler {

    private final LoginService loginService;

    public ErpLogoutHandler(LoginService loginService) {
        this.loginService = loginService;
    }

    @Override
    public void logout(HttpServletRequest request,
                       HttpServletResponse response,
                       Authentication authentication) {

        HttpSession session = request.getSession(false);
        if (session != null) {
            LoginUser user = (LoginUser) session.getAttribute("loginUser");
            if (user != null) {
                try {
                    loginService.recordLogout(user, request.getRemoteAddr());
                } catch (Exception ignored) {
                    // never block logout because of audit failure
                }
            }
        }
    }
}