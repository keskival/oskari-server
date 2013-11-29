<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Standalone servlet - ${viewName} view</title>

    <script type="text/javascript" src="http://code.jquery.com/jquery-1.7.2.min.js">
    </script>

    <!-- ############# css ################# -->
    <link
            rel="stylesheet"
            type="text/css"
            href="/Oskari${path}/css/icons.css"/>
    <link
            rel="stylesheet"
            type="text/css"
            href="/Oskari${path}/css/forms.css"/>
    <link
            rel="stylesheet"
            type="text/css"
            href="/Oskari${path}/css/portal.css"/>

    <link
            rel="stylesheet"
            type="text/css"
            href="/Oskari${path}/css/overwritten.css"/>

    <link
            rel="stylesheet"
            type="text/css"
            href="/Oskari${path}/css/parcel.css"/>

    <style type="text/css">
        @media screen {
            body {
                margin: 0;
                padding: 0;
            }

            #loginbar {
                padding: 10px 10px 0 16px;
                color: #CCC;
                vertical-align: bottom;
                margin-bottom: 8px;
                margin-top: 20px;
            }
            #loginbar a {
                color: #FFDE00;
                font-size: 8pt;
                line-height: 150%;
            }
            #mapdiv {
                width: 100%;
                background : white;
            }
            #maptools {
                background-color: #333438;
                height: 100%;
                position: absolute;
                top: 0;
                width: 153px;
                z-index: 2;
            }

            #contentMap {
                height: 100%;
                margin-left: 153px;
            }

            #login {
                margin-left: 5px;
            }

            #login input[type="text"], #login input[type="password"] {
                width: 90%;
                margin-bottom: 5px;
                background-image: url("/Oskari${path}/images/forms/input_shadow.png");
                background-repeat: no-repeat;
                padding-left: 5px;
                padding-right: 5px;
                border: 1px solid #B7B7B7;
                border-radius: 4px 4px 4px 4px;
                box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1) inset;
                color: #878787;
                font: 13px/100% Arial,sans-serif;
            }
            #login input[type="submit"] {
                width: 90%;
                margin-bottom: 5px;
                padding-left: 5px;
                padding-right: 5px;
                border: 1px solid #B7B7B7;
                border-radius: 4px 4px 4px 4px;
                box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1) inset;
                color: #878787;
                font: 13px/100% Arial,sans-serif;
            }
            #login p.error {
                font-weight: bold;
                color : red;
                margin-bottom: 10px;
            }

            #login a {
                color: #FFF;
                padding: 5px;
            }

        }
    </style>
    <!-- ############# /css ################# -->
</head>
<body>


<!--  CLIPPER -->
<script type="text/javascript"
        src="/Oskari/libraries/clipper/clipper.js">
</script>

<!--  JSTS -->
<script type="text/javascript"
        src="/Oskari/libraries/jsts/javascript.util.js">
</script>

<script type="text/javascript"
        src="/Oskari/libraries/jsts/jsts.js">
</script>

<!-- ############# css ################# -->
<link
        rel="stylesheet"
        type="text/css"
        href="/Oskari${path}/css/icons.css" />
<link
        rel="stylesheet"
        type="text/css"
        href="/Oskari${path}/css/forms.css" />
<link
        rel="stylesheet"
        type="text/css"
        href="/Oskari${path}/css/portal.css" />

<link
        rel="stylesheet"
        type="text/css"
        href="/Oskari${path}/css/overwritten.css"/>

<link
        rel="stylesheet"
        type="text/css"
        href="/Oskari${path}/css/parcel.css"/>


<style type="text/css">
</style>
<!-- ############# /css ################# -->
<nav id="maptools">
    <div id="logoarea">
        <img src="/Oskari/resources/parcel/images/logo.png" alt="Maanmittauslaitos" width="153" height="76">
    </div>
    <div id="loginbar">
    </div>
    <div id="menubar">
    </div>
    <div id="divider">
    </div>
    <div id="toolbar">
    </div>
    <div id="login">
        <c:choose>
            <c:when test="${!empty loginState}">
                <p class="error">Invalid password or username!!</p>
            </c:when>
        </c:choose>
        <c:choose>
            <c:when test="${!empty user}">
                <a href="/ajax/?action=logout">Logout</a>
            </c:when>
            <c:otherwise>
                <form action='${ajaxUrl}action=login&viewId=${viewId}' method="post" accept-charset="UTF-8">
                    <input size="16" id="username" name="username" type="text" placeholder="Username" autofocus
                           required>
                    <input size="16" id="password" name="password" type="password" placeholder="Password" required>
                    <input type="submit" id="submit" value="Log in">
                </form>
            </c:otherwise>
        </c:choose>
    </div>
</nav>
<div id="contentMap" class="oskariui container-fluid">
    <div id="menutoolbar" class="container-fluid"></div>
    <div class="row-fluid" style="height: 100%; background-color:white;">
        <div class="oskariui-left"></div>
        <div class="span12 oskariui-center" style="height: 100%; margin: 0;">
            <div id="mapdiv"></div>
        </div>
        <div class="oskari-closed oskariui-right">
            <div id="mapdivB"></div>
        </div>
    </div>
</div>
<!-- ############# Javascript ################# -->


<!--  OSKARI -->

<script type="text/javascript">
    var ajaxUrl = '${ajaxUrl}&';
    var viewId = '${viewId}';
    <%-- NOTE!!! HARDCODED LANGUAGE SINCE PARCEL BUNBLES ONLY HAS FINNISH LOCALIZATION --%>
    var language = 'fi';
    var preloaded = ${preloaded};
    var controlParams = ${controlParams};
</script>
<script type="text/javascript"
        src="/Oskari/bundles/bundle.js">
</script>

<!--  OPENLAYERS -->
<script type="text/javascript"
        src="/Oskari/packages/openlayers/startup.js">
</script>

<!-- Q -->
<script type="text/javascript" src="${urlPrefix}/Oskari/libraries/q/q.min.js">
</script>

<c:if test="${preloaded}">
    <!-- Pre-compiled application JS, empty unless created by build job -->
    <script type="text/javascript"
            src="/Oskari${path}/oskari.min.js">
    </script>
    <!-- Minified CSS for preload -->
    <link
            rel="stylesheet"
            type="text/css"
            href="/Oskari${path}/oskari.min.css"
            />
    <%--language files --%>
    <script type="text/javascript"
            src="/Oskari${path}/oskari_lang_all.js">
    </script>
    <script type="text/javascript"
            src="/Oskari${path}/oskari_lang_${themeDisplay.locale.language}.js">
    </script>
</c:if>

<script type="text/javascript"
        src="/Oskari${path}/index.js">
</script>

<!-- ############# /Javascript ################# -->

</body>
</html>
