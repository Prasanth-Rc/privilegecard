<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/jsp/usermanager/loginmanager/pageHeader.jsp" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Core ERP&reg; Dashboard</title>

</head>
<body>

<div class="layout">

    <!-- ================= SIDEBAR (3-level dynamic) ================= -->
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
                    <%--
                        A SubGroup always has at least one entry in "popups"
                        (the controller adds the row unconditionally), but when
                        there is no real 3rd-level menu, popupMenuId comes back
                        as 0 from the DB (COALESCE(pm.menuid,0)). So we check
                        the FIRST popup's id to decide whether this sub-menu is
                        really a folder of popups, or just a leaf itself.
                    --%>
                    <c:choose>
                        <%-- Sub menu WITH real popups → toggle folder --%>
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

                        <%-- Sub menu WITHOUT popups → itself is the clickable leaf --%>
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
        <a href="${pageContext.request.contextPath}/logout" class="side-link">
            <i class="mdi mdi-logout"></i> Log Out
        </a>
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
        // Leaf menu click
        // ============================================================
        $(document).on('click', '.js-page-link', function (e) {
            e.preventDefault();

            var menuId = $(this).data('menu-id');

            if (!menuId) {
                return;
            }

            var $form = $('<form>', {
                method: 'POST',
                action: '${pageContext.request.contextPath}/page'
            });

            $form.append($('<input>', {
                type: 'hidden',
                name: 'menuId',
                value: menuId
            }));

            // CSRF token
            $form.append($('<input>', {
                type: 'hidden',
                name: '${_csrf.parameterName}',
                value: '${_csrf.token}'
            }));

            $('body').append($form);

            $form.submit();
        });


        // ============================================================
        // Open parent menus when current page is active
        // ============================================================
        var $active = $('.js-page-link.active');

        if ($active.length) {

            $active.parents('.collapse').each(function () {

                var collapseElement = this;

                var bsCollapse = bootstrap.Collapse.getOrCreateInstance(
                    collapseElement,
                    {
                        toggle: false
                    }
                );

                bsCollapse.show();

            });

        } else {

            // Optional: open first main menu
            var first = $('.side-toggle').first();

            if (first.length) {

                var target = first.attr('href');

                var collapseElement = document.querySelector(target);

                if (collapseElement) {

                    var bsCollapse = bootstrap.Collapse.getOrCreateInstance(
                        collapseElement,
                        {
                            toggle: false
                        }
                    );

                    bsCollapse.show();

                }
            }
        }

    });
</script>

</body>
</html>