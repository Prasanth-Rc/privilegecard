<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 18-09-2026
  Time: 16:12
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Privilege Card</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrapcss/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/vendor.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrapcss/responsive.bootstrap5.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<!-- ================= TOPBAR ================= -->
<div class="topbar">
    <div class="brand">
        <div class="brand-badge"><i class="mdi mdi-crown"></i></div>
        <div>
            <p class="brand-name">Core ERP</p>
            <p class="brand-sub">Privilege Member Portal</p>
        </div>
    </div>

    <div class="user-chip">
        <div class="user-avatar">
            <c:choose>
                <c:when test="${not empty loginUser.employeeName}">
                    ${loginUser.employeeName.substring(0,1).toUpperCase()}
                </c:when>
                <c:otherwise>U</c:otherwise>
            </c:choose>
        </div>
        <div>
            <p class="user-name">${loginUser.employeeName}</p>
            <p class="user-role">${loginUser.designationName} &bull; ${loginUser.officeName}</p>
        </div>

        <%-- ============================================================
             LOGOUT — must be POST + CSRF for Spring Security
             ============================================================ --%>
        <form action="${pageContext.request.contextPath}/logout"
              method="post"
              class="m-0 d-inline">
            <input type="hidden"
                   name="${_csrf.parameterName}"
                   value="${_csrf.token}"/>
            <button type="submit"
                    class="logout-btn border-0 bg-transparent"
                    title="Log out">
                <i class="mdi mdi-logout"></i>
            </button>
        </form>
    </div>
</div>

<%-- ============================================================
     CSRF meta tags for any JS that needs them later
     ============================================================ --%>
<meta name="_csrf"        content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>

</body>

<script src="${pageContext.request.contextPath}/bootstrapjs/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.mask.min.js"></script>

</html>