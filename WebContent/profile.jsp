<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.ArrayList"
	import="cs201_hw3.Location"%>
<%
	boolean success = false;
	if (session.getAttribute("success") != null) {
		success = (boolean) session.getAttribute("success");
	}
	boolean all = false;
	String title;
	ArrayList<String> city_list = new ArrayList<String>();
	city_list = (ArrayList<String>) session.getAttribute("search_history");

	title = (String) session.getAttribute("user");
	if (title == null) {
		title = "Search History";
	} else {
		title = title + "'s Search History";
	}
	int num_city;
	int display = 1;
	String header;
	String to_js;
	String error = "";
	if (city_list != null && city_list.size() > 0) {
		num_city = city_list.size();
		header = "[\"City Name\",\"Temp. Low\",\"Temp. High\"]";
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		if (city_list.size() < 2) {
			display = 0;
		}
		//sb.append("[\"City Name\",\"Temp. Low\",\"Temp. High\"],");
		for (int i = 0; i < city_list.size(); i++) {
			sb.append("[");
			String city = city_list.get(i);
			sb.append("\"").append(city).append("\"");
			sb.append("]");
			if (i + 1 < city_list.size()) {
				sb.append(",");
			}
		}
		sb.append("]");
		to_js = sb.toString();
		System.out.println(to_js);
	} else {
		to_js = "[]";
		header = "[]";
		num_city = 0;
		error = (String) request.getAttribute("error");
		display = 0;

	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile</title>
<link rel="stylesheet" type="text/css" href="profile_style.css" />
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
<body onload="generateTable(); logged_in();">
	<div class="background-image" id="background"></div>
	<div class="header"></div>
	<div class="header_text" onclick="redirect();">
		<h2>WeatherMeister</h2>
	</div>
	<h1 id="name"><%=title%></h1>
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
	<div class="content">
		<div class="bg"></div>
		<div class="city_table">
			<table id="dvTable"></table>
		</div>
	</div>
</body>
<script type="text/javascript">
	function generateTable() {
		var content =
<%=to_js%>
	;
		if (content != "") {
			var table = document.createElement("TABLE");
			table.setAttribute('id', 'myTable');
			var rows =
<%=num_city%>
	;
			var row = table.insertRow(-1);
			for (var i = 0; i < rows; i++) {
				row = table.insertRow(-1);
				for (var j = 0; j < 1; j++) {
					var cell = row.insertCell(-1);
					cell.innerHTML = content[i][j];
				}
			}
			var dvTable = document.getElementById("dvTable");
			dvTable.innerHTML = "";
			dvTable.appendChild(table);
		}
	}
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
</html>