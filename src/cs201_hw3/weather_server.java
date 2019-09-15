package cs201_hw3;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

/**
 * Servlet implementation class weather_server
 */
@WebServlet("/weather_server")
public class weather_server extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Cities[] cities;
	HashMap<String, ArrayList<Cities>> same_name = new HashMap<String, ArrayList<Cities>>();
	String success_str; 
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public weather_server() {
		super();
		// TODO Auto-generated constructor stub
	}

	public void init() {
		Gson gson = new Gson();
		InputStream input = getServletContext().getResourceAsStream("city.list.json");
		BufferedReader br = new BufferedReader(new InputStreamReader(input));

		// JsonReader reader = new JsonReader(new InputStreamReader(input,"UTF-8"));

		cities = gson.fromJson(br, Cities[].class);
		ArrayList<Cities> city_list = new ArrayList<Cities>();
		city_list.add(cities[0]);
		same_name.put(cities[0].getName(), city_list);
		for (int i = 1; i < cities.length; i++) {
			ArrayList<Cities> found_city = same_name.get(cities[i].getName());
			if (found_city == null) {
				ArrayList<Cities> list = new ArrayList<Cities>();
				list.add(cities[i]);
				same_name.put(cities[i].getName(), list);

			} else {
				same_name.get(cities[i].getName()).add(cities[i]);
			}
		}
		// System.out.println(same_name.get("Hurzuf").toString());
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String next_pg = "/weather.jsp";
		String input_name = request.getParameter("cityname");
		String lat = request.getParameter("lat");
		String lon = request.getParameter("long");
		String redirect = request.getParameter("redirect");
		success_str = request.getParameter("success"); 
		boolean success = Boolean.parseBoolean(success_str); 
		if(success_str != null) {
			session.setAttribute("success", false);
		} 
		if (input_name != null) {
			success = (boolean)session.getAttribute("success"); 
			String user = (String)session.getAttribute("user");
			if(input_name.trim().length() > 0) {
				if(success) {
					ResultSet rs = null; 
					Connection conn = null; 
					PreparedStatement ps = null;
					PreparedStatement ps2 = null;
					int userID = 0; 
					try {
						Class.forName("com.mysql.cj.jdbc.Driver");
						conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/user_info?user=root&password=root");
						ps = conn.prepareStatement("SELECT * FROM usernames WHERE username=?");
						ps.setString(1,user);
						rs = ps.executeQuery();
						while(rs.next()) {
							 userID = rs.getInt("userID"); 
						}
						ps2 = conn.prepareStatement("INSERT INTO histories(history, userID) VALUES (?,?)");
						ps2.setString(1, input_name);	
						ps2.setInt(2, userID);
						ps2.executeUpdate(); 
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (ClassNotFoundException e) {
						// TODO Auto-generated catch block
						e.printStackTrace(); 
					} finally {
						try {
							if(ps != null) {ps.close();}
							if(ps2 != null) {ps2.close();}
							if(conn != null) {conn.close();}
						} catch(SQLException sqle) {
							System.out.println(sqle.getMessage());
						} 
					}
				}
			}
			input_name = input_name.toLowerCase();
			ArrayList<Cities> found_city = same_name.get(input_name);
			if (found_city == null) {
				session.setAttribute("found_city", null);
				session.setAttribute("citylist", null);
				next_pg = "/all_cities.jsp";
				request.setAttribute("error", "We don't have info on " + input_name + ".");
			} else if (redirect != null) {
				request.setAttribute("all", false);
				next_pg = "/info.jsp";
			} else {
				 success = (boolean)session.getAttribute("success"); 
				System.out.println(success);

				next_pg = "/all_cities.jsp";
				if(input_name.trim().length() == 0) {
					next_pg = "/weather.jsp";
				}
				ArrayList<Json> json_list = new ArrayList<Json>();
				for (int i = 0; i < found_city.size(); i++) {
					try {
						String api_key = "0d316dc36262b18fffe6292f9f2532a2";

						URL url = new URL("http://api.openweathermap.org/data/2.5/weather?id="
								+ found_city.get(i).getId() + "&appid=" + api_key);
						HttpURLConnection conn = (HttpURLConnection) url.openConnection();
						conn.setRequestMethod("GET");
						conn.setRequestProperty("Accept", "application/json");
						if (conn.getResponseCode() != 200) {
							throw new RuntimeException("Failed : HTTP error code : " + conn.getResponseCode());
						}
						BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
//						String output;
//						System.out.println("Output from Server .... \n");
//						while ((output = br.readLine()) != null) {
//							System.out.println(output);
//						}
						Gson gson = new Gson();
						Json json = gson.fromJson(br, Json.class);
						json_list.add(json);
						// System.out.println(json_list.get(0).getName() + " we here");
//						String output;
//						System.out.println("Output from Server .... \n");
//						while ((output = br.readLine()) != null) {
//							System.out.println(output);
//						}
						conn.disconnect();

					} catch (MalformedURLException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				ArrayList<Location> found_city_list = new ArrayList<Location>();
				for (int i = 0; i < json_list.size(); i++) {
					Json json = json_list.get(i);
					Location loc = new Location();
					loc.setCity(json.getName());
					loc.setCountry(json.getSys().get("country"));
					loc.setLatitude(json.getCoord().get("lat"));
					loc.setLongitude(json.getCoord().get("lon"));
					Date sunrise = new Date(Long.parseLong(json.getSys().get("sunrise")) * 1000);
					String[] sr_array = sunrise.toString().split(" ");
					loc.setSunrise(sr_array[3] + " " + sr_array[4]);
					Date sunset = new Date(Long.parseLong(json.getSys().get("sunset")) * 1000);
					String[] ss_array = sunset.toString().split(" ");
					loc.setSunset(ss_array[3] + " " + ss_array[4]);
					loc.setCurTemp(json.getMain().get("temp"));
					loc.setLow(json.getMain().get("temp_min"));
					loc.setHigh(json.getMain().get("temp_max"));
					loc.setHumidity(json.getMain().get("humidity"));
					loc.setWindSpd(json.getWind().get("speed"));
					if (json.getWind().get("deg") == null) {
						loc.setWindDir(0);

					} else {
						loc.setWindDir(json.getWind().get("deg"));
					}
					loc.setDescrip(json.getWeather().get(0).get("description"));
					found_city_list.add(loc);
				}
				session.setAttribute("citylist", found_city_list);
			}
		} else if (lat != null && lon != null) {
			next_pg = "/all_cities.jsp";
			//System.out.println(lat + " " + lon);
			BigDecimal bd_lat = new BigDecimal(lat);
			BigDecimal bd_lon = new BigDecimal(lon);
			bd_lat = bd_lat.setScale(2, RoundingMode.HALF_UP);
			bd_lon = bd_lon.setScale(2, RoundingMode.HALF_UP);
			double rounded_lat = bd_lat.doubleValue();
			double rounded_lon = bd_lon.doubleValue();
			//System.out.println(rounded_lat + " " + rounded_lon);
			ArrayList<Json> json_list = new ArrayList<Json>();
			try {
				String api_key = "0d316dc36262b18fffe6292f9f2532a2";

				URL url = new URL("http://api.openweathermap.org/data/2.5/weather?lat=" + rounded_lat + "&lon="
						+ rounded_lon + "&appid=" + api_key);
				HttpURLConnection conn = (HttpURLConnection) url.openConnection();
				conn.setRequestMethod("GET");
				conn.setRequestProperty("Accept", "application/json");
				if (conn.getResponseCode() != 200) {
					throw new RuntimeException("Failed : HTTP error code : " + conn.getResponseCode());
				}
				BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
//				String output;
//				System.out.println("Output from Server .... \n");
//				while ((output = br.readLine()) != null) {
//					System.out.println(output);
//				}
				Gson gson = new Gson();
				Json json = gson.fromJson(br, Json.class);
				json_list.add(json);

				// System.out.println(json_list.get(0).getName() + " we here");
//				String output;
//				System.out.println("Output from Server .... \n");
//				while ((output = br.readLine()) != null) {
//					System.out.println(output);
//				}
				conn.disconnect();

			} catch (MalformedURLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			ArrayList<Location> found_city_list = new ArrayList<Location>();
			for (int i = 0; i < json_list.size(); i++) {
				Json json = json_list.get(i);
				Location loc = new Location();
				loc.setCity(json.getName());
				loc.setCountry(json.getSys().get("country"));
				loc.setLatitude(json.getCoord().get("lat"));
				loc.setLongitude(json.getCoord().get("lon"));
				Date sunrise = new Date(Long.parseLong(json.getSys().get("sunrise")) * 1000);
				String[] sr_array = sunrise.toString().split(" ");
				loc.setSunrise(sr_array[3] + " " + sr_array[4]);
				Date sunset = new Date(Long.parseLong(json.getSys().get("sunset")) * 1000);
				String[] ss_array = sunset.toString().split(" ");
				loc.setSunset(ss_array[3] + " " + ss_array[4]);
				loc.setCurTemp(json.getMain().get("temp"));
				loc.setLow(json.getMain().get("temp_min"));
				loc.setHigh(json.getMain().get("temp_max"));
				loc.setHumidity(json.getMain().get("humidity"));
				loc.setWindSpd(json.getWind().get("speed"));
				if (json.getWind().get("deg") == null) {
					loc.setWindDir(0);

				} else {
					loc.setWindDir(json.getWind().get("deg"));
				}
				loc.setDescrip(json.getWeather().get(0).get("description"));
				found_city_list.add(loc);
			}
			session.setAttribute("citylist", found_city_list);

		} else {
			next_pg = "/weather.jsp";

		}

		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(next_pg);
		dispatch.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
