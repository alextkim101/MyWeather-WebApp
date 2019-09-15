<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" 
	import="cs201_hw3.Location" import="java.util.ArrayList"%>
<%
	ArrayList<Location> city_list = new ArrayList<Location>(); 
	city_list = (ArrayList<Location>) session.getAttribute("citylist");
	String error = (String) request.getAttribute("error");
	String city_name = "";
	city_name = request.getParameter("redirect");
	Location city = null; 
	for(int i = 0; i < city_list.size(); i++) {
		if(city_name.equalsIgnoreCase(city_list.get(i).getCity())) {
			city = city_list.get(i);
		}
	}
	//String state = city.getState() + ","; 
	String country = city.getCountry(); 
	String low = String.valueOf(city.getLow()) + " degrees Fahrenheit"; 
	String high = String.valueOf(city.getHigh()) + " degrees Fahrenheit"; 
	String lat = String.valueOf(city.getLatitude()); 
	String longi = String.valueOf(city.getLongitude()); 
	String windDir = String.valueOf(city.getWindDir())+" degrees"; 
	String windSpd = String.valueOf(city.getWindSpd())+" m/h"; 
	String humidity =String.valueOf(city.getHumidity())+"%";
	String curtemp = String.valueOf(city.getCurTemp())+ " degrees"; 
	String sunrise = city.getSunrise();
	String sunset = city.getSunset(); 
	
	boolean valid = true;

	if (city != null) {
		city_name = city.getCity();
	}
	String error_msg = (String) request.getAttribute("error_msg");
	if (error_msg == null) {
		error_msg = "";
	} else {
		valid = false;
	}
	String cityname = request.getParameter("redirect");
	if (cityname == null || cityname.trim().length() == 0) {
		cityname = "";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=city_name %></title>
<link rel="stylesheet" type="text/css" href="info_style.css" />
<script>
	function toggle(mode) {
		var city_mode = document.getElementById("city");
		var loc_mode = document.getElementById("loc");
		if (mode == 1) {
			city_mode.style.display = "inline-block";
			loc_mode.style.display = "none";
		} else {
			loc_mode.style.display = "inline-block";
			city_mode.style.display = "none";

		}
	}
	function flip(which) {
		var location = document.getElementById("earth"); 
		var locat_id = document.getElementById("locat_id"); 
		var low = document.getElementById("snow"); 
		var low_id = document.getElementById("low_id");
		var high =document.getElementById("sun");
		var high_id=document.getElementById("high_id");
		var wind =document.getElementById("wind");
		var wind_id=document.getElementById("wind_id");
		var drop =document.getElementById("drop");
		var drop_id=document.getElementById("drop_id");
		var loc_icon =document.getElementById("loc_icon");
		var loc_id=document.getElementById("loc_id");
		var thermo =document.getElementById("thermo");
		var thermo_id=document.getElementById("thermo_id");
		var sunrise =document.getElementById("sunrise");
		var sunrise_id=document.getElementById("sunrise_id");
		if(which == 0) {
			location.style.display="none";
			locat_id.style.display="block"; 
		} else if(which == 1) {
			low.style.display="none";
			low_id.style.display="block"; 
		} else if (which == 2) {
			high.style.display="none";
			high_id.style.display="block"; 
		} else if(which == 3) {
			wind.style.display="none";
			wind_id.style.display="block";
		} else if(which == 4) {
			drop.style.display="none";
			drop_id.style.display="block";
		} else if(which == 5) {
			loc_icon.style.display="none";
			loc_id.style.display="block";
		} else if(which == 6) {
			thermo.style.display="none";
			thermo_id.style.display="block";
		} else if(which == 7) {
			sunrise.style.display="none";
			sunrise_id.style.display="block";
		} 
	}
	function flipback(which) {
		var location = document.getElementById("earth"); 
		var locat_id = document.getElementById("locat_id"); 
		var low = document.getElementById("snow"); 
		var low_id = document.getElementById("low_id");
		var high =document.getElementById("sun");
		var high_id=document.getElementById("high_id");
		var wind =document.getElementById("wind");
		var wind_id=document.getElementById("wind_id");
		var drop =document.getElementById("drop");
		var drop_id=document.getElementById("drop_id");
		var loc_icon =document.getElementById("loc_icon");
		var loc_id=document.getElementById("loc_id");
		var thermo =document.getElementById("thermo");
		var thermo_id=document.getElementById("thermo_id");
		var sunrise =document.getElementById("sunrise");
		var sunrise_id=document.getElementById("sunrise_id");
		if(which == 0) {
			location.style.display="block";
			locat_id.style.display="none"; 
		} else if(which == 1) {
			low.style.display="block";
			low_id.style.display="none"; 
		} else if (which == 2) {
			high.style.display="block";
			high_id.style.display="none"; 
		} else if(which == 3) {
			wind.style.display="block";
			wind_id.style.display="none";
		} else if(which == 4) {
			drop.style.display="block";
			drop_id.style.display="none";
		} else if(which == 5) {
			loc_icon.style.display="block";
			loc_id.style.display="none";
		} else if(which == 6) {
			thermo.style.display="block";
			thermo_id.style.display="none";
		} else if(which == 7) {
			sunrise.style.display="block";
			sunrise_id.style.display="none";
		} 
	}
	function redirect() {
		window.location.href="http://localhost:8080/cs201_hw3/weather_server";
	}
</script>
</head>
<body>
	<div class="background-image"></div>
	<div class="header"></div>
	<h1 id="name"><%=city_name%></h1>
	<div class="search_field">
		<form action="weather_server" method="GET" class="bar">
			<div id="city">
				<input name="cityname" class="search_bar" />
				<button class="butt" type="submit">
					<img class="icon" src="magnifying_glass.jpeg" alt="Search">
				</button>
			</div>
			<div id="loc">
				<div id="lat_input">
					<input name="lat" class="lat_search_bar" placeholder="Latitude" />
				</div>
				<div id="long_input">
					<input name="long" class="long_search_bar" placeholder="Longtitude" />
					<button class="butt" type="submit">
						<img class="icon" src="magnifying_glass.jpeg" alt="Search">
					</button>
				</div>
			</div>
			<div id="mode">
				<input type="radio" name="mode_butt" onclick="toggle(1);"><font
					color="white">City</font><input type="radio" name="mode_butt"
					onclick="toggle(0);"><font color="white">Location(Lat./Long.)</font>
			</div>
		</form>
	</div>
	<div class="content">
		<div class="top">
			<figure id="location"> 
				<img src="planet-earth.png" onclick="flip(0);" id="earth">
				<div class="icons"id="locat_id" onclick="flipback(0);"> 
					<%=country %>
				</div>
				<figcaption>Location</figcaption>
			</figure>
			<figure id="low_temp"> 
				<img src="snowflake.png" onclick="flip(1);" id="snow"> 
				<div class="icons" id="low_id" onclick="flipback(1);"> 
					<%=low%>
				</div>
				<figcaption>Temp Low</figcaption>
			</figure>
			<figure id="high_temp"> 
				<img src="sun.png" onclick="flip(2);" id="sun"> 
				<div class="icons" id="high_id" onclick="flipback(2);"> 
					<%=high%>
				</div>
				<figcaption>Temp High</figcaption>
			</figure>
			<figure id="windy"> 
				<img src="wind.png" onclick="flip(3);" id="wind"> 
				<div class="icons" id="wind_id" onclick="flipback(3);"> 
					<%=windDir%><br/><%=windSpd%>
				</div>
				<figcaption>Wind</figcaption>
			</figure>
			<br/>
			<figure id="humidity"> 
				<img src="drop.png" onclick="flip(4);" id="drop">
				<div class="icons" id="drop_id" onclick="flipback(4);"> 
					<%=humidity%>
				</div> 
				<figcaption>Humidity</figcaption>
			</figure>
			<figure id="coord"> 
				<img src="LocationIcon.png" onclick="flip(5);" id="loc_icon"> 
				<div class="icons" id="loc_id" onclick="flipback(5);"> 
					<%=lat%><br/><%=longi%>
				</div>
				<figcaption>Coordinates</figcaption>
			</figure>
			<figure id="curr_temp"> 
				<img src="thermometer.png" onclick="flip(6);" id="thermo"> 
				<div class="icons" id="thermo_id" onclick="flipback(6);"> 
					<%=curtemp%>
				</div> 
				<figcaption>Current Temp</figcaption>
			</figure>
			<figure id="sunrise_icon"> 
				<img src="sunrise-icon.png" onclick="flip(7);" id="sunrise"> 
				<div class="icons" id="sunrise_id" onclick="flipback(7);"> 
					<%=sunrise%><br/><%=sunset%>
				</div>
				<figcaption>Sunrise/set</figcaption>
			</figure>
		</div>
	</div>

	<div class="header_text" onclick="redirect();">
		<h2>WeatherMeister</h2>
	</div>
</body>
</html>