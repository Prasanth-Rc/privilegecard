<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/jsp/usermanager/loginmanager/pageHeader.jsp" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Core ERP&reg; Dashboard</title>

    <%-- ============================================================
         CSRF TOKEN #1 — expose as meta tags so JS can read them
         (used by the dynamic /page form and any future AJAX calls)
         ============================================================ --%>
    <meta name="_csrf"        content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
</head>
<body>

<%-- ============================================================
     CSRF TOKEN #2 — global hidden input, useful if you ever need
     to inject the token into a form via JS with $('input[name=_csrf]')
     ============================================================ --%>
<input type="hidden" id="globalCsrfToken"
       name="${_csrf.parameterName}"
       value="${_csrf.token}"/>

<div class="layout">

    <!-- ================= SIDEBAR ================= -->
    <div class="sidebar overflow-auto">
        <p class="side-title">Main Menu</p>

        <c:forEach var="mainEntry" items="${groupedMenus}">
            <a class="side-link side-toggle"
               data-bs-toggle="collapse"
               href="#mainGroup${mainEntry.key}"
               role="button"
               aria-expanded="false">
                <i class="mdi mdi-folder"></i>
                <span>${mainEntry.value.name}</span>
                <i class="mdi mdi-chevron-down caret"></i>
            </a>

            <div class="collapse" id="mainGroup${mainEntry.key}">
                <c:forEach var="subEntry" items="${mainEntry.value.subs}">
                    <c:choose>
                        <c:when test="${not empty subEntry.value.popups and subEntry.value.popups[0].popupMenuId != 0}">
                            <a class="side-link side-toggle sub-toggle"
                               data-bs-toggle="collapse"
                               href="#subGroup${mainEntry.key}_${subEntry.key}"
                               role="button"
                               aria-expanded="false"
                               style="padding-left:30px;">
                                <i class="mdi mdi-folder-open"></i>
                                <span>${subEntry.value.name}</span>
                                <i class="mdi mdi-chevron-down caret"></i>
                            </a>
                            <div class="collapse" id="subGroup${mainEntry.key}_${subEntry.key}">
                                <c:forEach var="pm" items="${subEntry.value.popups}">
                                    <a href="#"
                                       class="side-link popup-link js-page-link ${pm.popupMenuId eq currentMenu ? 'active' : ''}"
                                       data-menu-id="${pm.popupMenuId}"
                                       style="padding-left:46px;">
                                        <i class="mdi mdi-circle-medium"></i>
                                            ${pm.popupMenuName}
                                    </a>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="#"
                               class="side-link sub-toggle js-page-link ${subEntry.key eq currentMenu ? 'active' : ''}"
                               data-menu-id="${subEntry.key}"
                               style="padding-left:30px;">
                                <i class="mdi mdi-circle-medium"></i>
                                <span>${subEntry.value.name}</span>
                            </a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>
        </c:forEach>

        <p class="side-title" style="margin-top:22px;">Account</p>
        <a href="#" class="side-link"><i class="mdi mdi-face-man-profile"></i> My Profile</a>

        <%-- ============================================================
             CSRF TOKEN #3 — logout form (POST)
             ============================================================ --%>
        <form action="${pageContext.request.contextPath}/logout"
              method="post"
              class="m-0">
            <input type="hidden"
                   name="${_csrf.parameterName}"
                   value="${_csrf.token}"/>
            <button type="submit"
                    class="side-link border-0 bg-transparent w-100 text-start">
                <i class="mdi mdi-logout"></i> Log Out
            </button>
        </form>
    </div>

    <!-- ================= CONTENT ================= -->
    <div class="content">

        <div class="welcome-card">
            <p class="welcome-title">Welcome back, ${loginUser.employeeName}&nbsp;👋</p>
            <p class="welcome-sub">Here's a quick overview of your ERP workspace for today.</p>
        </div>

        <div class="stat-grid">
            <div class="stat-card">
                <div class="stat-icon bg-orange"><i class="mdi mdi-nature-people"></i></div>
                <p class="stat-value">248</p>
                <p class="stat-label">Total Employees</p>
            </div>
            <div class="stat-card">
                <div class="stat-icon bg-blue"><i class="mdi mdi-group"></i></div>
                <p class="stat-value">12</p>
                <p class="stat-label">Departments</p>
            </div>
            <div class="stat-card">
                <div class="stat-icon bg-green"><i class="mdi mdi-check"></i></div>
                <p class="stat-value">37</p>
                <p class="stat-label">Approved Today</p>
            </div>
            <div class="stat-card">
                <div class="stat-icon bg-pink"><i class="mdi mdi-bell"></i></div>
                <p class="stat-value">5</p>
                <p class="stat-label">Notifications</p>
            </div>
        </div>

        <p class="section-title">Quick Access</p>
        <div class="menu-grid">
            <a href="#" class="menu-tile">
                <div class="menu-tile-icon"><i class="mdi mdi-card-account-details"></i></div>
                <div>
                    <p class="menu-tile-name">Employee Directory</p>
                    <p class="menu-tile-sub">View all staff</p>
                </div>
            </a>
            <a href="#" class="menu-tile">
                <div class="menu-tile-icon"><i class="mdi mdi-calendar-alert"></i></div>
                <div>
                    <p class="menu-tile-name">Leave Requests</p>
                    <p class="menu-tile-sub">Pending approvals</p>
                </div>
            </a>
            <a href="#" class="menu-tile">
                <div class="menu-tile-icon"><i class="mdi mdi-radar"></i></div>
                <div>
                    <p class="menu-tile-name">Reports</p>
                    <p class="menu-tile-sub">Monthly summaries</p>
                </div>
            </a>
        </div>

    </div>
</div>

<script>
    $(function () {

        // ============================================================
        // Read CSRF token from <meta> — safest way for JS
        // ============================================================
        var CSRF_TOKEN  = $('meta[name="_csrf"]').attr('content');
        var CSRF_HEADER = $('meta[name="_csrf_header"]').attr('content');

        // Fallback: if meta isn't present, read from the global hidden input
        if (!CSRF_TOKEN) {
            CSRF_TOKEN = $('#globalCsrfToken').val();
        }

        // ============================================================
        // CSRF TOKEN #4 — dynamically-built POST form for /page
        // ============================================================
        $(document).on('click', '.js-page-link', function (e) {
            e.preventDefault();

            var menuId = $(this).data('menu-id');
            if (!menuId) return;

            var $form = $('<form>', {
                method: 'POST',
                action: '${pageContext.request.contextPath}/page'
            });

            $form.append($('<input>', {
                type: 'hidden',
                name: 'menuId',
                value: menuId
            }));

            // CSRF token injected into the dynamic form
            $form.append($('<input>', {
                type: 'hidden',
                name: '${_csrf.parameterName}',
                value: '${_csrf.token}'
            }));

            $('body').append($form);
            $form.submit();
        });

        // ============================================================
        // CSRF TOKEN #5 — template for any future AJAX call
        // ------------------------------------------------------------
        // Usage:
        //   $.ajax({
        //       url: '/somepost',
        //       type: 'POST',
        //       headers: csrfHeaders(),
        //       data: {...}
        //   });
        // ============================================================
        function csrfHeaders() {
            var h = {};
            if (CSRF_HEADER && CSRF_TOKEN) {
                h[CSRF_HEADER] = CSRF_TOKEN;
            } else if (CSRF_TOKEN) {
                h['X-CSRF-TOKEN'] = CSRF_TOKEN;  // fallback default header name
            }
            return h;
        }
        window.csrfHeaders = csrfHeaders;   // expose globally

        // ============================================================
        // Auto-open active menu
        // ============================================================
        var $active = $('.js-page-link.active');

        if ($active.length) {
            $active.parents('.collapse').each(function () {
                bootstrap.Collapse
                    .getOrCreateInstance(this, { toggle: false })
                    .show();
            });
        } else {
            var first = $('.side-toggle').first();
            if (first.length) {
                var target = first.attr('href');
                var collapseElement = document.querySelector(target);
                if (collapseElement) {
                    bootstrap.Collapse
                        .getOrCreateInstance(collapseElement, { toggle: false })
                        .show();
                }
            }
        }

    });
</script>

</body>
</html>