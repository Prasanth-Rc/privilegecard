<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Core ERP&reg; - Login</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrapcss/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/vendor.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrapcss/responsive.bootstrap5.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    <style>
        :root {
            --card-lav: #FF9800;
            --card-lav-dark: #2525B8;
            --card-ink: #17178F;
            --card-mint: #F57C00;
            --card-bg: #F8F9FF;
            --card-field-bg: #F7F8FF;
            --card-field-border: #C9CCF5;

            --grad-brand: linear-gradient(135deg, #FF9800, #F57C00);
            --grad-brand-hover: linear-gradient(135deg, #2525B8, #17178F);
            --dot-pattern: radial-gradient(circle, #777dd5 1.5px, transparent 2px);
        }

        .login-body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f8f9ff 0%, #eef0ff 50%, #f8f8ff 100%);
            padding: 24px 12px;
        }

        .brand-sub, .link-muted, .gsi-login-btn, .form-check-label {
            font-weight: 500;
        }

        .brand-sub, .card-meta-label, .card-number, .link-muted, .form-check-label, .deco-dots::before {
            color: var(--card-lav-dark);
        }

        .link-muted, .input-icon-wrap i {
            transition: color .3s ease;
        }

        .login-background::before {
            content: "";
            position: absolute;
            width: 750px;
            height: 750px;
            left: 50%;
            top: 45%;
            transform: translate(-50%, -50%);
            border-radius: 50%;
            background: radial-gradient(circle, rgba(255, 255, 255, .95) 0%, rgba(240, 242, 255, .65) 45%, rgba(240, 242, 255, 0) 72%);
        }

        .bg-grid {
            opacity: .20;
            background-image: linear-gradient(rgba(80, 90, 180, .035) 1px, transparent 1px),
            linear-gradient(90deg, rgba(80, 90, 180, .035) 1px, transparent 1px);
            background-size: 45px 45px;
        }

        .hospital-area {
            width: 380px;
            height: 270px;
            opacity: .15;
            color: #7c82d9;
        }

        .hospital-main {
            left: 95px;
            width: 145px;
            height: 210px;
            background: linear-gradient(to right, rgba(110, 116, 210, .55), rgba(150, 154, 230, .25));
            clip-path: polygon(0 15%, 42% 15%, 42% 0, 58% 0, 58% 15%, 100% 15%, 100% 100%, 0 100%);
        }

        .hospital-small {
            width: 100px;
            height: 145px;
            background: rgba(125, 130, 215, .28);
        }

        .hospital-right {
            left: 240px;
            width: 105px;
            height: 125px;
            background: rgba(125, 130, 215, .22);
        }

        .hospital-cross {
            left: 134px;
            bottom: 210px;
            width: 42px;
            height: 42px;
            background: rgba(120, 126, 215, .42);
            border-radius: 5px;
        }

        .hospital-cross::before, .hospital-cross::after {
            content: "";
            position: absolute;
            background: white;
        }

        .hospital-cross::before {
            width: 12px;
            height: 30px;
            left: 15px;
            top: 6px;
        }

        .hospital-cross::after {
            width: 30px;
            height: 12px;
            left: 6px;
            top: 15px;
        }

        .hospital-window {
            left: var(--l);
            bottom: var(--b);
            width: 18px;
            height: 9px;
            background: rgba(255, 255, 255, .70);
            border-radius: 2px;
        }

        .ecg-area {
            right: -10px;
            top: 38px;
            width: 430px;
            height: 90px;
            opacity: .18;
        }

        .ecg-line {
            top: 48px;
            height: 2px;
            background: #777dd5;
        }

        .ecg-pulse {
            top: 48px;
            left: 65px;
            width: 230px;
            height: 2px;
            background: #777dd5;
        }

        .ecg-pulse::before {
            content: "";
            position: absolute;
            left: 45px;
            top: -35px;
            width: 2px;
            height: 35px;
            background: #777dd5;
            transform: rotate(12deg);
        }

        .ecg-pulse::after {
            content: "";
            position: absolute;
            left: 47px;
            top: -35px;
            width: 55px;
            height: 70px;
            border-top: 2px solid #777dd5;
            border-right: 2px solid #777dd5;
            transform: skewX(-25deg) rotate(15deg);
        }

        .bg-purple-circle {
            width: 260px;
            height: 260px;
            right: -105px;
            bottom: -115px;
            background: radial-gradient(circle at 35% 30%, rgba(176, 170, 245, .55), rgba(130, 125, 220, .24) 60%, rgba(130, 125, 220, .05) 100%);
        }

        .bg-purple-circle-small {
            width: 150px;
            height: 150px;
            right: -70px;
            bottom: 75px;
            background: rgba(180, 175, 245, .10);
        }

        .bg-orange-circle {
            width: 72px;
            height: 72px;
            left: -27px;
            bottom: -27px;
            opacity: .70;
            background: radial-gradient(circle at 35% 35%, #ffd58c, #ffb84d);
        }

        .bg-dots-left, .bg-dots-right {
            background-image: var(--dot-pattern);
        }

        .bg-dots-left {
            left: 25px;
            top: 125px;
            width: 120px;
            height: 70px;
            opacity: .18;
            background-size: 18px 18px;
        }

        .bg-dots-right {
            right: 80px;
            bottom: 130px;
            width: 80px;
            height: 60px;
            opacity: .13;
            background-size: 16px 16px;
        }

        .bg-line-left {
            left: 190px;
            top: 120px;
            width: 180px;
            height: 1px;
            background: linear-gradient(90deg, rgba(110, 116, 210, 0), rgba(110, 116, 210, .22), rgba(110, 116, 210, 0));
        }

        .bg-line-right {
            right: 190px;
            bottom: 105px;
            width: 150px;
            height: 1px;
            background: linear-gradient(90deg, rgba(110, 116, 210, 0), rgba(110, 116, 210, .18), rgba(110, 116, 210, 0));
        }

        @media (max-width: 768px) {
            .hospital-area {
                transform: scale(.75);
                transform-origin: bottom left;
                opacity: .10;
            }

            .ecg-area {
                transform: scale(.65);
                transform-origin: top right;
                opacity: .12;
            }

            .bg-purple-circle {
                width: 190px;
                height: 190px;
            }

            .bg-dots-left, .bg-dots-right {
                opacity: .08;
            }
        }

        .privilege-card {
            max-width: 420px;
            border-radius: 28px;
            background: var(--card-bg);
            border: 1px solid #DDE1FF;
            box-shadow: 0 20px 45px rgba(37, 37, 184, .14);
            transition: transform .3s ease;
        }

        .privilege-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 25px 55px rgba(37, 37, 184, .20);
        }

        .privilege-card::before {
            content: "₹ $ € £ ¥ ₿ ₣ ₩ ₪ ₨ ₫ ₭ ₱ ₴ ₸ ₮ ₦ ₡ ₲ ₵";
            position: absolute;
            inset: 0;
            font-size: 100px;
            font-weight: 700;
            color: rgba(127, 119, 221, .04);
            white-space: pre-wrap;
            word-break: break-all;
            line-height: 1;
            letter-spacing: 30px;
            pointer-events: none;
            z-index: 0;
            display: flex;
            flex-wrap: wrap;
            align-content: space-evenly;
            justify-content: space-evenly;
            padding: 20px;
            transform: rotate(-15deg) scale(1.15);
            animation: floatSymbols 20s ease-in-out infinite alternate;
        }

        @keyframes floatSymbols {
            0% {
                transform: rotate(-15deg) scale(1.15) translateX(0);
            }
            100% {
                transform: rotate(-10deg) scale(1.2) translateX(10px);
            }
        }

        .deco-shine {
            left: -100%;
            width: 60%;
            background: linear-gradient(120deg, transparent 20%, rgba(255, 255, 255, .5) 40%, rgba(255, 255, 255, .8) 50%, rgba(255, 255, 255, .5) 60%, transparent 80%);
            transform: skewX(-20deg);
            animation: shineMove 8s ease-in-out infinite;
        }

        @keyframes shineMove {
            0% {
                left: -100%;
                opacity: 0;
            }
            10% {
                opacity: 1;
            }
            40% {
                left: 150%;
                opacity: 1;
            }
            50% {
                opacity: 0;
            }
            100% {
                left: 150%;
                opacity: 0;
            }
        }

        .privilege-card::after {
            content: "";
            position: absolute;
            top: 0;
            right: -100%;
            width: 40%;
            height: 100%;
            background: linear-gradient(120deg, transparent 30%, rgba(255, 255, 255, .2) 50%, transparent 70%);
            transform: skewX(-15deg);
            z-index: 1;
            animation: shineMoveReverse 12s ease-in-out infinite;
            pointer-events: none;
        }

        @keyframes shineMoveReverse {
            0% {
                right: -100%;
                opacity: 0;
            }
            15% {
                opacity: 1;
            }
            45% {
                right: 150%;
                opacity: 1;
            }
            55% {
                opacity: 0;
            }
            100% {
                right: 150%;
                opacity: 0;
            }
        }

        .deco-circle-1, .deco-circle-2 {
            animation: pulseCircle 6s ease-in-out infinite alternate;
        }

        .deco-circle-1 {
            top: -80px;
            right: -70px;
            width: 250px;
            height: 250px;
            opacity: .4;
            background: radial-gradient(circle, #B9C0FF 0%, transparent 70%);
        }

        .deco-circle-2 {
            bottom: -100px;
            left: -80px;
            width: 280px;
            height: 280px;
            opacity: .3;
            background: radial-gradient(circle, #FFD180 0%, transparent 70%);
            animation-duration: 8s;
            animation-direction: alternate-reverse;
        }

        @keyframes pulseCircle {
            0% {
                transform: scale(1);
                opacity: .4;
            }
            100% {
                transform: scale(1.1);
                opacity: .6;
            }
        }

        .deco-dots {
            top: 10px;
            right: 10px;
            width: 60px;
            height: 60px;
            opacity: .15;
        }

        .deco-dots::before {
            content: '✦ ✦ ✦ ✦';
            position: absolute;
            top: 0;
            right: 0;
            font-size: 12px;
            letter-spacing: 8px;
            line-height: 1.8;
        }

        .card-top {
            padding: 28px 28px 6px;
        }

        .brand-badge {
            width: 40px;
            height: 40px;
            border-radius: 12px;
            font-size: 22px;
            background: var(--grad-brand);
            box-shadow: 0 4px 15px rgba(127, 119, 221, .3);
        }

        .brand-name {
            color: var(--card-ink);
            font-size: 17px;
            letter-spacing: -.3px;
        }

        .brand-sub {
            font-size: 11px;
        }

        .tier-pill {
            font-size: 11px;
            color: #085041;
            background: rgba(93, 202, 165, .25);
            border: 1px solid rgba(93, 202, 165, .4);
            padding: 5px 14px;
            backdrop-filter: blur(4px);
        }

        .chip {
            width: 44px;
            height: 32px;
            border-radius: 6px;
            background: linear-gradient(135deg, #FFD166, #FF9800);
            box-shadow: 0 2px 10px rgba(255, 152, 0, .25);
        }

        .card-number {
            font-size: 20px;
            letter-spacing: 4px;
            margin: 16px 0 20px;
            text-shadow: 0 1px 2px rgba(255, 255, 255, .5);
        }

        .card-meta-label {
            font-size: 9px;
            letter-spacing: .6px;
        }

        .card-meta-value {
            font-size: 15px;
            color: var(--card-ink);
        }

        .points-value {
            color: var(--card-mint);
        }

        .login-panel {
            background: rgba(255, 255, 255, .94);
            backdrop-filter: blur(10px);
            border-top: 1px solid rgba(221, 225, 255, .75);
            border-radius: 28px 28px 0 0;
            margin-top: 20px;
            padding: 28px 28px 22px;
        }

        .input-icon-wrap i {
            left: 14px;
            color: #777CC7;
            font-size: 17px;
        }

        .input-icon-wrap:focus-within i {
            color: var(--card-lav);
        }

        .form-control-card {
            background: var(--card-field-bg);
            border: 1px solid var(--card-field-border);
            border-radius: 14px;
            padding: 12px 16px 12px 42px;
            font-size: 14px;
            color: var(--card-ink);
            transition: all .3s ease;
        }

        .form-control-card:focus {
            background: #fff;
            border-color: var(--card-lav-dark);
            box-shadow: 0 0 0 4px rgba(37, 37, 184, .10);
            color: var(--card-ink);
        }

        .btn-login {
            background: var(--grad-brand);
            font-size: 15px;
            border-radius: 14px;
            padding: 13px;
            transition: all .3s ease;
        }

        .btn-login::before {
            content: "";
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(120deg, transparent, rgba(255, 255, 255, .2), transparent);
            transition: left .6s ease;
        }

        .btn-login:hover::before {
            left: 100%;
        }

        .btn-login:hover {
            background: var(--grad-brand-hover);
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(37, 37, 184, .28);
        }

        .link-muted {
            font-size: 12px;
        }

        .link-muted:hover {
            color: var(--card-mint);
        }

        .link-sep {
            color: #C9CCF5;
        }

        .gsi-login-btn {
            border: 1px solid #D9DCFA;
            border-radius: 14px;
            padding: 10px;
            font-size: 13px;
            color: #3c3c3c;
            gap: 10px;
            transition: all .3s ease;
        }

        .gsi-login-btn:hover {
            background: #F7F8FF;
            border-color: #B8BDF0;
            transform: translateY(-1px);
            box-shadow: 0 4px 15px rgba(37, 37, 184, .12);
        }

        .footer-note {
            font-size: 11px;
            color: #777CC7;
            margin-top: 18px;
            max-width: 420px;
        }

        .footer-note a {
            color: #777CC7;
            transition: color .3s ease;
        }

        .footer-note a:hover {
            color: var(--card-lav-dark);
        }

        .alert-card {
            max-width: 420px;
            margin-bottom: 14px;
            font-size: 13px;
        }

        .form-check-label {
            font-size: 12px;
        }

        .form-check-input:checked {
            background-color: var(--card-lav);
            border-color: var(--card-lav-dark);
        }

        .form-check-input:focus {
            box-shadow: 0 0 0 3px rgba(37, 37, 184, .15);
        }

        @media (max-width: 480px) {
            .privilege-card {
                border-radius: 20px;
            }

            .card-top {
                padding: 20px 20px 4px;
            }

            .login-panel {
                padding: 20px 20px 18px;
            }

            .privilege-card::before {
                font-size: 70px;
                letter-spacing: 20px;
            }
        }
    </style>
</head>

<body class="d-flex align-items-center justify-content-center position-relative overflow-hidden min-vh-100 login-body">

<!-- ===== Background decorations ===== -->
<div class="login-background position-fixed top-0 start-0 w-100 h-100 pe-none z-0">
    <div class="bg-grid position-absolute top-0 start-0 w-100 h-100"></div>

    <div class="hospital-area position-absolute start-0 bottom-0">
        <div class="hospital-small position-absolute start-0 bottom-0"></div>
        <div class="hospital-main position-absolute bottom-0"></div>
        <div class="hospital-right position-absolute bottom-0"></div>
        <div class="hospital-cross position-absolute"></div>
        <div class="hospital-window position-absolute" style="--l:112px;--b:175px"></div>
        <div class="hospital-window position-absolute" style="--l:145px;--b:175px"></div>
        <div class="hospital-window position-absolute" style="--l:112px;--b:145px"></div>
        <div class="hospital-window position-absolute" style="--l:145px;--b:145px"></div>
        <div class="hospital-window position-absolute" style="--l:112px;--b:115px"></div>
        <div class="hospital-window position-absolute" style="--l:145px;--b:115px"></div>
        <div class="hospital-window position-absolute" style="--l:112px;--b:85px"></div>
        <div class="hospital-window position-absolute" style="--l:145px;--b:85px"></div>
        <div class="hospital-window position-absolute" style="--l:20px;--b:105px"></div>
        <div class="hospital-window position-absolute" style="--l:55px;--b:105px"></div>
        <div class="hospital-window position-absolute" style="--l:20px;--b:75px"></div>
        <div class="hospital-window position-absolute" style="--l:55px;--b:75px"></div>
        <div class="hospital-window position-absolute" style="--l:20px;--b:45px"></div>
        <div class="hospital-window position-absolute" style="--l:55px;--b:45px"></div>
    </div>

    <div class="ecg-area position-absolute">
        <div class="ecg-line position-absolute start-0 end-0"></div>
        <div class="ecg-pulse position-absolute"></div>
    </div>

    <div class="bg-purple-circle position-absolute rounded-circle"></div>
    <div class="bg-purple-circle-small position-absolute rounded-circle"></div>
    <div class="bg-orange-circle position-absolute rounded-circle"></div>
    <div class="bg-dots-left position-absolute"></div>
    <div class="bg-dots-right position-absolute"></div>
    <div class="bg-line-left position-absolute"></div>
    <div class="bg-line-right position-absolute"></div>
</div>

<!-- ===== Center wrapper ===== -->
<div class="center-wrapper w-100 d-flex flex-column align-items-center justify-content-center min-vh-100 position-relative z-3">

    <%-- Error message --%>
    <% if (request.getParameter("error") != null) { %>
    <div class="alert alert-danger alert-card mx-auto rounded-4 text-center py-2" role="alert">
        Invalid username or password.
    </div>
    <% } %>

    <div class="privilege-card w-100 mx-auto position-relative overflow-hidden">
        <div class="deco-circle-1 position-absolute rounded-circle z-0"></div>
        <div class="deco-circle-2 position-absolute rounded-circle z-0"></div>
        <div class="deco-shine position-absolute top-0 h-100 z-1 pe-none"></div>
        <div class="deco-dots position-absolute z-0"></div>

        <!-- ===== Card top ===== -->
        <div class="card-top position-relative z-2">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div class="d-flex align-items-center gap-2">
                    <div class="brand-badge d-flex align-items-center justify-content-center text-white">
                        <i class="mdi mdi-crown"></i>
                    </div>
                    <div>
                        <p class="brand-name m-0 fw-bold">Core ERP</p>
                        <p class="brand-sub m-0">Privilege member portal</p>
                    </div>
                </div>
                <span class="tier-pill fw-semibold rounded-pill">Gold tier</span>
            </div>

            <div class="d-flex align-items-center gap-3 mb-2">
                <div class="chip"></div>
                <i class="mdi mdi-wifi" style="transform:rotate(90deg);color:var(--card-lav-dark);font-size:20px;"></i>
            </div>

            <div class="card-number fw-semibold">&bull;&bull;&bull;&bull; &bull;&bull;&bull;&bull; &bull;&bull;&bull;&bull;
                xxxx
            </div>

            <div class="d-flex justify-content-between mb-3">
                <div>
                    <p class="card-meta-label m-0 text-uppercase fw-semibold">Card holder</p>
                    <p class="card-meta-value m-0 fw-semibold">Guest User</p>
                </div>
                <div class="text-end">
                    <p class="card-meta-label m-0 text-uppercase fw-semibold">Reward points</p>
                    <p class="card-meta-value m-0 fw-semibold points-value">Y,YYY <i class="ti ti-arrow-up-right"
                                                                                     style="font-size:13px;"></i></p>
                </div>
            </div>
        </div>

        <!-- ===== Login panel ===== -->
        <div class="login-panel position-relative z-2">
            <form id="login_form"
                  action="${pageContext.request.contextPath}/login"
                  method="post"
                  autocomplete="off">

                <div class="input-icon-wrap position-relative mb-3">
                    <i class="mdi mdi-face-man-shimmer position-absolute top-50 translate-middle-y"></i>
                    <input type="text"
                           class="form-control form-control-card"
                           id="username"
                           name="username"
                           placeholder="User ID"
                           autocomplete="username"
                           required/>
                </div>

                <div class="input-icon-wrap position-relative mb-2">
                    <i class="mdi mdi-lock position-absolute top-50 translate-middle-y"></i>
                    <input type="password"
                           class="form-control form-control-card"
                           id="password"
                           name="password"
                           placeholder="Password"
                           autocomplete="current-password"
                           maxlength="32"/>
                </div>

                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                <div class="form-check mb-3">
                    <input class="form-check-input"
                           type="checkbox"
                           id="chkShowPassword"/>
                    <label class="form-check-label" for="chkShowPassword">Show password</label>
                </div>

                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div class="form-check m-0">
                        <input class="form-check-input"
                               type="checkbox"
                               name="remember-me"
                               id="rememberMe"/>
                        <label class="form-check-label" for="rememberMe">Remember me</label>
                    </div>
                    <a href="${pageContext.request.contextPath}/forgot-password"
                       class="link-muted text-decoration-none">
                        Forgot password?
                    </a>
                </div>

                <button type="submit"
                        class="btn btn-login w-100 mb-2 border-0 text-white fw-semibold position-relative overflow-hidden"
                        id="_save">
                    Log in <i class="mdi mdi-arrow-right ms-1"></i>
                </button>

                <div class="d-flex justify-content-center gap-2 mb-3" style="font-size:12px;">
                    <a href="${pageContext.request.contextPath}/login"
                       class="link-muted text-decoration-none">Reset</a>
                </div>

                <div class="d-flex align-items-center gap-2 mb-3">
                    <hr class="flex-grow-1" style="border-color:#DDE1FF;">
                    <span style="font-size:11px;color:#777CC7;">or</span>
                    <hr class="flex-grow-1" style="border-color:#DDE1FF;">
                </div>

                <button type="button"
                        class="gsi-login-btn w-100 bg-white d-flex align-items-center justify-content-center"
                        id="googleLoginBtn">
                    <svg width="18" height="18" viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
                        <path fill="#EA4335"
                              d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"></path>
                        <path fill="#4285F4"
                              d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"></path>
                        <path fill="#FBBC05"
                              d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"></path>
                        <path fill="#34A853"
                              d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.15 1.45-4.92 2.3-8.16 2.3-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"></path>
                        <path fill="none" d="M0 0h48v48H0z"></path>
                    </svg>
                    Sign in with Google
                </button>
            </form>
        </div>
    </div>

    <p class="footer-note text-center">
        Developed by Firstline Infotech Pvt Ltd, T.Nagar, Chennai, Tamil Nadu, India.<br>
        Tel: +91-44-24342709 &nbsp;|&nbsp;
        <a href="https://firstlineinfotech.com" target="_blank">www.firstlineinfotech.com</a><br>
        Date: <apt:date/>
    </p>
</div>

<script src="${pageContext.request.contextPath}/bootstrapjs/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.mask.min.js"></script>

<script>
    $(function () {

        /* ---------------------------------------------
         * 1. Auto-focus the username field on load
         * --------------------------------------------- */
        $('#username').trigger('focus');

        /* ---------------------------------------------
         * 2. Show / hide password
         * --------------------------------------------- */
        $('#chkShowPassword').on('change', function () {
            $('#password').attr('type', this.checked ? 'text' : 'password');
        });

        /* ---------------------------------------------
         * 3. Login button: basic client-side validation
         *    (Spring Security still handles the actual POST)
         * --------------------------------------------- */
        $('#login_form').on('submit', function (e) {
            const u = $.trim($('#username').val());
            const p = $.trim($('#password').val());

            if (!u) {
                e.preventDefault();
                $('#username').trigger('focus');
                alert('Please enter your User ID.');
                return false;
            }
            // if (!p) {
            //     e.preventDefault();
            //     $('#password').trigger('focus');
            //     alert('Please enter your password.');
            //     return false;
            // }

            // Disable button + show "please wait" state
            $('#_save')
                .prop('disabled', true)
                .html('Please wait... <i class="ti ti-loader-2 ms-1"></i>');

            // allow submit to continue
            return true;
        });

        /* ---------------------------------------------
         * 4. Google OAuth2 sign-in
         * --------------------------------------------- */
        $('#googleLoginBtn').on('click', function () {
            window.location.href =
                "${pageContext.request.contextPath}/oauth2/authorization/google";
        });

        /* ---------------------------------------------
         * 5. Small nicety: clear the "error" query
         *    string so refresh doesn't re-show it.
         * --------------------------------------------- */
        if (window.history.replaceState && location.search.indexOf('error') !== -1) {
            window.history.replaceState(null, '', location.pathname);
        }

    });
</script>
</body>
</html>