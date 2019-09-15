package cs201_hw3;

import java.util.Map;

public class Cities {
	Map<String, Double> coord; 
	int id; 
	String name; 
	String country;
	
	
	public Map<String, Double> getCoord() {
		return coord;
	}
	public void setCoord(Map<String, Double> coord) {
		this.coord = coord;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name.toLowerCase();
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	} 


}
