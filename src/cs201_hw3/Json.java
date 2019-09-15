package cs201_hw3;

import java.util.List;
import java.util.Map;

public class Json {
	Map<String,Double> coord; 
	List<Map<String,String>> weather; 
	String base; 
	Map<String,Double> main; 
	Map<String,Double> wind; 
	Map<String,Double> clouds; 
	Map<String,Double> rain; 
	int dt; 
	Map<String,String> sys; 
	int id; 
	String name; 
	int cod;
	public Map<String, Double> getCoord() {
		return coord;
	}
	public void setCoord(Map<String, Double> coord) {
		this.coord = coord;
	}
	public List<Map<String, String>> getWeather() {
		return weather;
	}
	public void setWeather(List<Map<String, String>> weather) {
		this.weather = weather;
	}
	public String getBase() {
		return base;
	}
	public void setBase(String base) {
		this.base = base;
	}
	public Map<String, Double> getMain() {
		return main;
	}
	public void setMain(Map<String, Double> main) {
		this.main = main;
	}
	public Map<String, Double> getWind() {
		return wind;
	}
	public void setWind(Map<String, Double> wind) {
		this.wind = wind;
	}
	
	public Map<String, Double> getClouds() {
		return clouds;
	}
	public void setClouds(Map<String, Double> clouds) {
		this.clouds = clouds;
	}
	public Map<String, Double> getRain() {
		return rain;
	}
	public void setRain(Map<String, Double> rain) {
		this.rain = rain;
	}
	public int getDt() {
		return dt;
	}
	public void setDt(int dt) {
		this.dt = dt;
	}
	
	public Map<String, String> getSys() {
		return sys;
	}
	public void setSys(Map<String, String> sys) {
		this.sys = sys;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getCod() {
		return cod;
	}
	public void setCod(int cod) {
		this.cod = cod;
	} 
	
}
