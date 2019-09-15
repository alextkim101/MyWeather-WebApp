package cs201_hw3;
public class Location {
	private String city;
	private String state; 
	private String country; 
	private double latitude; 
	private double longitude; 
	private String sunrise; 
	private String sunset; 
	private double curTemp;
	private double low;
	private double high;
	private double humidity;
	private float pressure;
	private float vis;
	private double windSpd;
	private double windDir;
	private String descrip;

	

	public Location() {
		super();
		// TODO Auto-generated constructor stub
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	public String getSunrise() {
		return sunrise;
	}

	public void setSunrise(String sunrise) {
		this.sunrise = sunrise;
	}

	public String getSunset() {
		return sunset;
	}

	public void setSunset(String sunset) {
		this.sunset = sunset;
	}

	

	public double getCurTemp() {
		return curTemp;
	}

	public void setCurTemp(double curTemp) {
		this.curTemp = curTemp;
	}

	public double getLow() {
		return low;
	}

	public void setLow(double low) {
		this.low = low;
	}

	public double getHigh() {
		return high;
	}

	public void setHigh(double high) {
		this.high = high;
	}

	public void setHigh(int high) {
		this.high = high;
	}

	public double getHumidity() {
		return humidity;
	}

	public void setHumidity(double humidity) {
		this.humidity = humidity;
	}

	public float getPressure() {
		return pressure;
	}

	public void setPressure(float pressure) {
		this.pressure = pressure;
	}

	public float getVis() {
		return vis;
	}

	public void setVis(float vis) {
		this.vis = vis;
	}

	public double getWindSpd() {
		return windSpd;
	}

	public void setWindSpd(double windSpd) {
		this.windSpd = windSpd;
	}

	
	public double getWindDir() {
		return windDir;
	}

	public void setWindDir(double windDir) {
		this.windDir = windDir;
	}

	public String getDescrip() {
		return descrip;
	}

	public void setDescrip(String descrip) {
		this.descrip = descrip;
	}

}
