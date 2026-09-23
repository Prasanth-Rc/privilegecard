package com.privilegecard.privilegecard.service;

import com.privilegecard.privilegecard.entity.LoginUser;
import com.privilegecard.privilegecard.entity.MenuContent;
import com.privilegecard.privilegecard.repository.LoginUserRepository;

import org.springframework.stereotype.Service;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.List;

@Service
public class LoginService {

    private final LoginUserRepository loginUserRepository;

    public LoginService(LoginUserRepository loginUserRepository) {
        this.loginUserRepository = loginUserRepository;
    }

    /* ============================================================
     * AUTHENTICATION
     * ============================================================ */

    /**
     * Authenticate a user.
     *
     * @param username    the alias name
     * @param rawPassword the plain password from the form
     * @return LoginUser (with menus loaded) if valid, null otherwise
     */
    public LoginUser authenticate(String username, String rawPassword) {

        if (username == null || username.isBlank()) {
            return null;
        }

//        String hashedPassword = md5Triple(rawPassword);

        List<LoginUser> users =
                loginUserRepository.findByAliasNameNative(username, rawPassword);

        if (users == null || users.isEmpty()) {
            return null;
        }

        LoginUser user = users.get(0);

        // Load menus
        List<MenuContent> menus =
                loginUserRepository.findMenusNative(user.getEmployeeId());
        user.setMenus(menus);

        return user;
    }

    /* ============================================================
     * AUDIT LOGGING
     * ============================================================ */

    public void recordLogin(LoginUser user, String ipAddress) {
        if (user == null) return;
        loginUserRepository.recordLogin(
                user.getOfficeId(),
                user.getEmployeeId(),
                ipAddress
        );
    }

    public void recordLogout(LoginUser user, String ipAddress) {
        if (user == null) return;
        loginUserRepository.recordLogout(
                user.getOfficeId(),
                user.getEmployeeId(),
                ipAddress
        );
    }

    /* ============================================================
     * HELPERS (private)
     * ============================================================ */

    private String md5Triple(String raw) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] bytes = raw.getBytes(StandardCharsets.UTF_8);
            for (int i = 0; i < 3; i++) {
                bytes = md.digest(bytes);
                md.reset();
            }
            StringBuilder sb = new StringBuilder(32);
            for (byte b : bytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            throw new IllegalStateException("MD5 not available", e);
        }
    }
}