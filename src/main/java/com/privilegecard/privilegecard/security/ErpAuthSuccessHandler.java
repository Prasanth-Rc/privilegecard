package com.privilegecard.privilegecard.security;

import com.privilegecard.privilegecard.entity.LoginUser;
import com.privilegecard.privilegecard.service.LoginService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class ErpAuthSuccessHandler implements AuthenticationSuccessHandler {

    private final LoginService loginService;

    public ErpAuthSuccessHandler(LoginService loginService) {
        this.loginService = loginService;
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Authentication authentication)
            throws IOException, ServletException {

        String username = authentication.getName();

        // Load full user + menus
        LoginUser loginUser = loginService.loadWithMenus(username);

        // Audit log
        loginService.recordLogin(loginUser, request.getRemoteAddr());

        // Put in session
        HttpSession session = request.getSession(true);
        session.setAttribute("loginUser", loginUser);
        session.setAttribute("sessionId", session.getId());

        response.sendRedirect(request.getContextPath() + "/home");
    }
}