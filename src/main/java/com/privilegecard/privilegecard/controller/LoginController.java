package com.privilegecard.privilegecard.controller;

import com.privilegecard.privilegecard.entity.LoginUser;
import com.privilegecard.privilegecard.entity.MenuContent;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
public class LoginController {

    /* ============================================================
     * ROOT
     * ============================================================ */
    @GetMapping("/")
    public String index() {
        return "redirect:/loginForm";
    }

    /* ============================================================
     * LOGIN PAGE (GET only — POST handled by Spring Security)
     * ============================================================ */
    @GetMapping("/loginForm")
    public String loginForm() {
        return "usermanager/loginmanager/LoginForm";
    }

    /* ============================================================
     * HOME
     * ============================================================ */
    @GetMapping("/home")
    public String home(HttpSession session,
                       Model model,
                       HttpServletRequest request) {

        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/loginForm";
        }

        Map<Long, MainGroup> groupedMenus = groupMenus(loginUser.getMenus());

        String currentPage = request.getRequestURI()
                .replace(request.getContextPath() + "/", "");

        model.addAttribute("loginUser",    loginUser);
        model.addAttribute("groupedMenus", groupedMenus);
        model.addAttribute("currentPage",  currentPage);

        return "usermanager/loginmanager/home";
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