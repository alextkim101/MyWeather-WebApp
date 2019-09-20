<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="cs201_hw3.Location"%>

<%
	boolean success = false; 
	if(session.getAttribute("success") != null) {
		 success = (boolean) session.getAttribute("success");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WeatherMeister</title>
<link rel="stylesheet" type="text/css" href="index.css" />
<script>
	function toggle(mode) {
		var city_mode = document.getElementById("wrap");
		var loc_mode = document.getElementById("loc");
		var map_butt = document.getElementById("map_butt");
		if (mode == 1) {
			city_mode.style.display = "inline-block";
			loc_mode.style.display = "none";
			map_butt.style.display = "none";
		} else {
			loc_mode.style.display = "inline-block";
			city_mode.style.display = "none";
			map_butt.style.display = "inline-block";

		}
	}
	function map_mode(mode) {
		var map_block = document.getElementById("map");
		var content_block = document.getElementById("contents");
		var header_block = document.getElementById("header_text");
		var background_block = document.getElementById("background");
		if (mode == 0) {
			content_block.style.display = "none";
			map_block.style.display = "block";
			header_block.style.filter = "brightness(20%)";
		} else {
			map_block.style.display = "none";
			content_block.style.display = "block";
			header_block.style.filter = "brightness(100%)";
			background_block.style.filter = "brightness(60%) blur(3px)"
		}

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
	<div class="header_text" id="header_text">
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
	<div class="content" id="contents">
		<img class="resize" src="logo.png"><br />
		<div class="search_field">
			<div class="wrap" id="wrap">
				<form action="weather_server" method="GET" class="bar">
					<div id="city">
						<input name="cityname" class="search_bar" />
						<button class="butt" type="submit">
							<img class="icon" src="magnifying_glass.jpeg" alt="Search">
						</button>
					</div>
				</form>
			</div>
			<div id="loc">
				<form action="weather_server" method="GET" class="bar">
					<div id="lat_input">
						<input id="lat" name="lat" class="lat_search_bar"
							placeholder="Latitude" />
					</div>
					<div id="long_input">
						<input id="long" name="long" class="long_search_bar"
							placeholder="Longtitude" />
						<button class="butt" type="submit">
							<img class="icon" src="magnifying_glass.jpeg" alt="Search">
						</button>
					</div>
				</form>
			</div>
			<div id="map_butt">
				<button class="butt" onclick="map_mode(0); initMap();">
					<img class="map_icon" src="MapIcon.png">
				</button>
			</div>
		</div>
		<br /> <input type="radio" name="mode" id="city_butt"
			onclick="toggle(1);"><font color="white">City</font><input
			type="radio" name="mode" id="loc_butt" onclick="toggle(0);"><font
			color="white">Location(Lat./Long.)</font> <br />
	</div>
	<div class="map" id="map" onclick="map_mode(1);"></div>
	<script>
		var map;
		function initMap() {
			var lat = document.getElementById("lat");
			var lng = document.getElementById("long");

			map = new google.maps.Map(document.getElementById('map'), {
				center : {
					lat : -34.397,
					lng : 150.644
				},
				zoom : 8
			});

			google.maps.event.addListener(map, 'click', function(event) {
				lat.setAttribute('value', event.latLng.lat());
				lng.setAttribute('value', event.latLng.lng());
			});
		}
	</script>
	<script
		src="GOOGLE_API_KEY"
		async defer></script>
	<script type="text/javascript">
		function signout() {
			var form = document.createElement("form");
			form.setAttribute('action','weather_server');
			form.setAttribute('method', 'GET'); 
			var input = document.createElement("input");
			input.setAttribute('name','success'); 
			form.appendChild(input); 
			document.location.href='http://localhost:8080/cs201_hw3/weather_server?cityname=&lat=&long=&success=false';
		}
	</script>
</body>
</html>