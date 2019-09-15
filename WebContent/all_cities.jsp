<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="cs201_hw3.Location"
	 import="java.util.ArrayList"%>
<%
	boolean all = false; 
	String title; 
	ArrayList<Location> city_list = new ArrayList<Location>();
		city_list = (ArrayList<Location>) session.getAttribute("citylist");

	if(city_list != null && city_list.size() > 1) {
 		title = "All Cities"; 
	} else {
		title = "";
	}
	int num_city; 
	int display = 1; 
	String header;
	String to_js; 
	String error = "";
	if(city_list != null && city_list.size() > 0) {
		 num_city = city_list.size();
		 header = "[\"City Name\",\"Temp. Low\",\"Temp. High\"]"; 
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		if(city_list.size() < 2) {
			display = 0; 
		}
		//sb.append("[\"City Name\",\"Temp. Low\",\"Temp. High\"],");
		for (int i = 0; i < city_list.size(); i++) {
			sb.append("[");
			Location city = city_list.get(i);
			sb.append("\"").append(city.getCity()).append("\"").append(",");
			sb.append(city.getLow()).append(",");
			sb.append(city.getHigh()).append(",");
			sb.append("]");
			if (i + 1 < city_list.size()) {
				sb.append(",");
			}
		}
		sb.append("]");
		 to_js = sb.toString();
	} else {
		 to_js = "[]";
		 header = "[]"; 
		 num_city =0; 
		 error = (String)request.getAttribute("error");
		 display = 0; 
		 
	}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Results</title>
<link rel="stylesheet" type="text/css" href="all_cities_style.css" />
<script>
function redirect() {
	window.location.href="http://localhost:8080/cs201_hw3/weather_server";
}
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
function display_bar() {
	var display = <%=display%>;
	var select_bar = document.getElementById("select_bar");
	if(display == 0) {
		select_bar.style.display = "none"; 
	} else {
		select_bar.style.display = "inline-block"; 
	}
	
}
</script>
</head>
<body onload="generateTable(1); display_bar();">
	<div class="background-image"></div>
	<div class="header"></div>
	<div class="header_text" onclick="redirect();">
		<h2>WeatherMeister</h2>
	</div>
	<h1 id="name"><%=title%></h1>
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
		<div class="bg"></div>
		<div class="city_table">
			<h1 id="error"><%=error%></h1>
			<table id="dvTable"></table>
		</div>
		<div class="select_bar" id="select_bar">
			Sort By: <br /> <select name="rating" id="rating"
				onchange="generateTable(this.value);">
				<option value="1">City Name A-Z</option>
				<option value="2">City Name Z-A</option>
				<option value="3">Temp. Low ASC</option>
				<option value="4">Temp. Low DSC</option>
				<option value="5">Temp. High ASC</option>
				<option value="6">Temp. High DSC</option>

			</select>
		</div>
	</div>
</body>
<script type="text/javascript">
	function generateTable(value) {
		var header = <%=header%>;
		var content = <%=to_js%>;
		if(content != "") {
			if (value == 3) {
				content.sort(function(a, b) { return (a[1] < b[1] ? -1 : (a[1] > b[1] ? 1 : 0)); });
			} else if (value == 4) {
				content.sort(function(a, b) { return (a[1] > b[1] ? -1 : (a[1] < b[1] ? 1 : 0)); });
			} else if (value == 1) {
				content.sort(function(a, b) { return (a[0] < b[0] ? -1 : (a[0] > b[0] ? 1 : 0)); });
			} else if (value == 2) {
				content.sort(function(a, b) { return (a[0] > b[0] ? -1 : (a[0] < b[0] ? 1 : 0)); });
			} else if (value == 5) {
				content.sort(function(a, b) { return (a[2] < b[2] ? -1 : (a[2] > b[2] ? 1 : 0)); });
			} else if (value == 6) {
				content.sort(function(a, b) { return (a[2] > b[2] ? -1 : (a[2] < b[2] ? 1 : 0)); });
			}
	 		var table = document.createElement("TABLE");
	 		table.setAttribute('id', 'myTable');   
			var rows = <%=num_city%>;
			var row = table.insertRow(-1);
			for (var i = 0; i < 3; i++) {
				var headerCell = document.createElement("TH");
				headerCell.innerHTML = header[i];
				row.appendChild(headerCell);
			}
			for (var i = 0; i < rows; i++) {
				row = table.insertRow(-1);
				for (var j = 0; j < 3; j++) {
					var cell = row.insertCell(-1);
					if(j == 0) {
					var url = content[i][0].replace(" ","+");
					var form = document.createElement("form");
					form.setAttribute('action','weather_server');
					form.setAttribute('method', 'GET'); 
					var input = document.createElement("input");
					input.setAttribute('name','redirect'); 
					form.appendChild(input); 
					cell.setAttribute('onclick',"document.location.href='http://localhost:8080/cs201_hw3/weather_server?cityname=&lat=&long=&redirect=" + url +"';");
					}
					cell.innerHTML = content[i][j];
				}
			}
			var dvTable = document.getElementById("dvTable");
			dvTable.innerHTML = "";
			dvTable.appendChild(table);
		} else {
			var display = <%=display%>;
			var select_bar = document.getElementById("select_bar");
			if(display == 0) {
				select_bar.style.display = "none"; 
			} else {
				select_bar.style.display = "inline-block"; 
			}
		}
	}
</script>
</html>