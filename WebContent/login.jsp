<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	boolean success = false;
	if (session.getAttribute("success") != null) {
		success = (boolean) session.getAttribute("success");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" type="text/css" href="login_style.css" />
<script>
	function redirect() {
		window.location.href = "http://localhost:8080/cs201_hw3/weather_server";
	}
	function to_register() {
		window.location.href = "http://localhost:8080/cs201_hw3/register.jsp";
	}
	function to_login() {
		window.location.href = "http://localhost:8080/cs201_hw3/login.jsp";
	}
	function to_profile() {
		window.location.href = "http://localhost:8080/cs201_hw3/profile_server";

	}
	function logged_in() {
		var profile = document.getElementById("profile");
		var signout = document.getElementById("signout");
		var login = document.getElementById("login");
		var register = document.getElementById("register");
		var success =
<%=success%>
	;

		if (success == true) {
			login.style.display = "none";
			register.style.display = "none";
			profile.style.display = "block";
			signout.style.display = "block";
		} else {
			login.style.display = "block";
			register.style.display = "block";
			profile.style.display = "none";
			signout.style.display = "none";
		}
	}
</script>
</head>
<body onload="logged_in();">
	<div class="background-image" id="background"></div>
	<div class="header"></div>
	<div class="header_text" id="header_text" onclick="redirect();">
		<h2>WeatherMeister</h2>
	</div>
	<div id="login" onclick="to_login();">
		<h1>Login</h1>
	</div>
	<div id="profile" onclick="to_profile();">
		<h1>Profile</h1>
	</div>
	<div id="register" onclick="to_register();">
		<h1>Register</h1>
	</div>
	<div id="signout" onclick="signout();">
		<h1>Sign out</h1>
	</div>
	<img class="resize" src="Keychain_Locked@2x.png">
	<div class="content" id="contents"></div>
	<div class="login">
		<form action="weather_server" method="GET" class="bar">
			Username </br> <input name="username" class="input"> </br> Password </br> <input
				type="password" name="password" class="input"> </br> <input
				type="submit" name="all" id="all" value="Login">
		</form>
	</div>
	<script type="text/javascript">
		function signout() {
			var form = document.createElement("form");
			form.setAttribute('action', 'weather_server');
			form.setAttribute('method', 'GET');
			var input = document.createElement("input");
			input.setAttribute('name', 'success');
			form.appendChild(input);
			document.location.href = 'http://localhost:8080/cs201_hw3/weather_server?cityname=&lat=&long=&success=false';
		}
	</script>
</body>

</html>