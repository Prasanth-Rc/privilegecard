package com.privilegecard.privilegecard.service;

import com.privilegecard.privilegecard.entity.LoginUser;
import com.privilegecard.privilegecard.entity.MenuContent;
import com.privilegecard.privilegecard.repository.LoginUserRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LoginService {

    private final LoginUserRepository loginUserRepository;

    public LoginService(LoginUserRepository loginUserRepository) {
        this.loginUserRepository = loginUserRepository;
    }

    /* ============================================================
     * Used by ErpAuthSuccessHandler — load user + menus
     * ============================================================ */
    public LoginUser loadWithMenus(String aliasName) {

        if (aliasName == null || aliasName.isBlank()) return null;

        LoginUser user = loginUserRepository.findByAlias(aliasName);
        if (user == null) return null;

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
}