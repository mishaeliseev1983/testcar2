<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.*"%>
<html>
<head>
<title>Web auto</title>
<link href="js/style.css" rel="stylesheet">
<script type="text/javascript">

<%
HttpSession currentSession = request.getSession();
Object remember_me= currentSession.getAttribute("remember_me");
if (remember_me != null && remember_me.toString().equals("on"))
	response.sendRedirect("search.jsp");
%>
</script>
</head> 

<body>

	<div class="tg" align="center"> 
	   
      <form method="post"  action="LoginServlet">
    	<h3>Залогиньтесь, пожалуйста!</h3>  
        <p><input type="text" name="login" value="" placeholder="Логин"></p>
        <p><input type="password" name="password" value="" placeholder="Пароль"></p>
        <p>
          <label>
            <input type="checkbox" name="remember_me" id="remember_me">
            Запомнить меня
          </label>
        </p>
        <p><input type="submit" name="commit" value="Войти" id="btnCommit" ></p>
      </form>
      </div>
</body>
</html>