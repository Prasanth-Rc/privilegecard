package com.privilegecard.privilegecard.controller;

import com.privilegecard.privilegecard.entity.LoginUser;

import com.privilegecard.privilegecard.repository.PageControllerRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class PageController {

    private final PageControllerRepository PageControllerRepository;

    public PageController(PageControllerRepository pageControllerRepository) {
        PageControllerRepository = pageControllerRepository;
    }


    @PostMapping("/page")
    public String pagePost(@RequestParam("menuId") Long menuId,
                           HttpSession session) {

        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/loginForm";

        String realPage = PageControllerRepository.findPageByMenuId(menuId);

        if (realPage == null || realPage.isBlank()) {
            return "redirect:/home";
        }

        // strip .jsp if DB stores it
        if (realPage.toLowerCase().endsWith(".jsp")) {
            realPage = realPage.substring(0, realPage.length() - 4);
        }

        // strip leading slash if DB stores "/accounts/master/..."
        while (realPage.startsWith("/")) {
            realPage = realPage.substring(1);
        }

        session.setAttribute("currentPage", realPage);
        session.setAttribute("currentMenu", menuId);

        // redirect to GET so F5 refresh works without resubmitting
        return "redirect:/page";
    }

    // ============================================================
    // 2) GET /page → render whatever is in session
    //    URL stays /privilegecard/page
    // ============================================================
    @GetMapping("/page")
    public String pageGet(HttpSession session, Model model) {

        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/loginForm";

        String realPage = (String) session.getAttribute("currentPage");
        if (realPage == null) return "redirect:/home";

        model.addAttribute("currentMenu", session.getAttribute("currentMenu"));
        model.addAttribute("pageTitle",   session.getAttribute("currentMenu"));

        // ⭐ RETURN the view — Spring forwards internally.
        //    Browser URL stays /page.
        return realPage;
    }
}
