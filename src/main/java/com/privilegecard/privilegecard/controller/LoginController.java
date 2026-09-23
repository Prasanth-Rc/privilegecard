package com.privilegecard.privilegecard.controller;

import com.privilegecard.privilegecard.entity.LoginUser;
import com.privilegecard.privilegecard.entity.MenuContent;
import com.privilegecard.privilegecard.service.LoginService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
public class LoginController {

    private final LoginService loginService;

    public LoginController(LoginService loginService) {
        this.loginService = loginService;
    }

    /* ============================================================
     * ROOT
     * ============================================================ */

    @GetMapping("/")
    public String index() {
        return "redirect:/loginForm";
    }

    /* ============================================================
     * LOGIN PAGE
     * ============================================================ */

    @GetMapping("/loginForm")
    public String loginForm() {
        return "usermanager/loginmanager/LoginForm";
    }

    /* ============================================================
     * LOGIN
     * ============================================================ */

    @PostMapping("/login")
    public String login(
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            HttpSession session,
            HttpServletRequest request,
            Model model) {

        System.out.println("======================================");
        System.out.println("LOGIN REQUEST RECEIVED");
        System.out.println("Username : " + username);
        System.out.println("======================================");

        try {

            // 1. Authenticate (Service)
            LoginUser loginUser = loginService.authenticate(username, password);

            // 2. Invalid login
            if (loginUser == null) {
                System.out.println("LOGIN FAILED");
                model.addAttribute("error", "Invalid username or password.");
                model.addAttribute("username", username);
                return "usermanager/loginmanager/LoginForm";
            }

            // 3. Success
            System.out.println("LOGIN SUCCESS");
            System.out.println("Employee ID : " + loginUser.getEmployeeId());
            System.out.println("Menus loaded : "
                    + (loginUser.getMenus() == null ? 0 : loginUser.getMenus().size()));

            // 4. Audit log (Service)
            loginService.recordLogin(loginUser, request.getRemoteAddr());

            // 5. Store in session (Controller)
            session.setAttribute("loginUser", loginUser);

            System.out.println("Session user created");
            System.out.println("Session ID : " + session.getId());

            return "redirect:/home";

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Login error: " + e.getMessage());
            model.addAttribute("username", username);
            return "usermanager/loginmanager/LoginForm";
        }
    }

    /* ============================================================
     * HOME
     * ============================================================ */

    @GetMapping("/home")
    public String home(HttpSession session,
                       Model model,
                       HttpServletRequest request) {

        System.out.println("======================================");
        System.out.println("HOME REQUEST");
        System.out.println("Session ID : " + session.getId());
        System.out.println("======================================");

        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

        if (loginUser == null) {
            System.out.println("NO LOGIN USER IN SESSION");
            return "redirect:/loginForm";
        }

        System.out.println("Logged in employee : " + loginUser.getEmployeeId());

        // Group menus for the JSP
        Map<Long, MainGroup> groupedMenus = groupMenus(loginUser.getMenus());

        System.out.println("Main groups : " + groupedMenus.size());

        String currentPage = request.getRequestURI()
                .replace(request.getContextPath() + "/", "");

        model.addAttribute("loginUser",    loginUser);
        model.addAttribute("groupedMenus", groupedMenus);
        model.addAttribute("currentPage",  currentPage);

        return "usermanager/loginmanager/home";
    }

    /* ============================================================
     * LOGOUT
     * ============================================================ */

    @GetMapping("/logout")
    public String logout(HttpSession session, HttpServletRequest request) {

        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

        if (loginUser != null) {
            loginService.recordLogout(loginUser, request.getRemoteAddr());
        }

        session.invalidate();
        return "redirect:/loginForm";
    }

    /* ============================================================
     * HELPER: group menus for the JSP
     * ============================================================ */

    private Map<Long, MainGroup> groupMenus(List<MenuContent> menus) {

        Map<Long, MainGroup> grouped = new LinkedHashMap<>();

        if (menus == null) return grouped;

        for (MenuContent m : menus) {

            MainGroup main = grouped.computeIfAbsent(
                    m.getMainMenuId(),
                    id -> new MainGroup(m.getMainMenuName())
            );

            SubGroup sub = main.getSubs().computeIfAbsent(
                    m.getSubMenuId(),
                    id -> new SubGroup(m.getSubMenuName(), m.getSubMenuPage())
            );

            sub.getPopups().add(m);
        }

        return grouped;
    }

    /* ============================================================
     * HELPER CLASSES FOR THE JSP
     * ============================================================ */

    public static class MainGroup {
        private final String name;
        private final Map<Long, SubGroup> subs = new LinkedHashMap<>();

        public MainGroup(String name) { this.name = name; }
        public String getName() { return name; }
        public Map<Long, SubGroup> getSubs() { return subs; }
    }

    public static class SubGroup {
        private final String name;
        private final String page;
        private final List<MenuContent> popups = new ArrayList<>();

        public SubGroup(String name, String page) {
            this.name = name;
            this.page = page;
        }

        public String getName() { return name; }
        public String getPage() { return page; }
        public List<MenuContent> getPopups() { return popups; }
    }
}