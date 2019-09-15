package cs201_hw3;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class sql_server
 */
@WebServlet("/sql_server")
public class sql_server extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public sql_server() {
        super();
        // TODO Auto-generated constructor stub
    }

    public void init() {
    	Connection conn = null; 
		PreparedStatement ps = null; //
		Statement sm = null; 
		ResultSet rs = null; //if executing a query 
    	try { 
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/","root","root");
			String update = "DROP DATABASE IF EXISTS user_info";
			String create = "CREATE DATABASE user_info"; 
			String use = "USE user_info";
			String username = "CREATE TABLE usernames (userID INT(11) PRIMARY KEY AUTO_INCREMENT, username VARCHAR(50) NOT NULL)";
			String password = "CREATE TABLE passwords (passID INT(11) PRIMARY KEY AUTO_INCREMENT, password VARCHAR(50) NOT NULL)";
			String history = "CREATE TABLE histories (hisID INT(11) PRIMARY KEY AUTO_INCREMENT, history VARCHAR(50) NOT NULL, userID INT(11) NOT NULL,"
					+ "FOREIGN KEY (userID) REFERENCES usernames(userID))";
			sm = conn.createStatement(); 
			sm.addBatch(update);
			sm.addBatch(create); 
			sm.addBatch(use);
			sm.addBatch(username);
			sm.addBatch(password); 
			sm.addBatch(history);
			sm.executeBatch(); 
		} catch (SQLException sqle) {
			System.out.println(sqle.getMessage()); 
		} catch (ClassNotFoundException cnfe) {
			System.out.println(cnfe.getMessage());
		} finally {
			try {
				if(rs != null) {rs.close();}
				if(ps != null) {ps.close();}
				if(conn != null) {conn.close();}
			} catch(SQLException sqle) {
				System.out.println(sqle.getMessage());
			}
		}
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		HttpSession session = request.getSession();
		response.setContentType("text/html"); 
		PrintWriter out = response.getWriter();
		String username = request.getParameter("username"); 
		String password = request.getParameter("password"); 
		String confirm = request.getParameter("confirm");
		boolean password_not_null = false; 
		boolean confirm_not_null = false; 
		boolean success = true; 
		if(username == null || username.trim().length() == 0) {
			out.println("<font color=\"red\"> Your username cannot be blank </font> <br/>"); 
		} else {
			Connection conn = null; 
			PreparedStatement ps = null; //
			ResultSet rs = null; //if executing a query 
			String check = null;
			try {
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/user_info?user=root&password=root");
				ps = conn.prepareStatement("SELECT * FROM usernames WHERE username=?");
				ps.setString(1,username);
				rs = ps.executeQuery(); 
				while(rs.next()) {
					 check = rs.getString("username"); 
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				try {
					if(rs != null) {rs.close();}
					if(ps != null) {ps.close();}
					if(conn != null) {conn.close();}
				} catch(SQLException sqle) {
					System.out.println(sqle.getMessage());
				}
			}
			if(check != null) {
				out.println("<font color=\"red\"> That username is already taken</font> <br/>"); 
				success = false; 
			}
		}
		if(password == null || password.trim().length() == 0) {
			out.println("<font color=\"red\"> Your password cannot be blank </font> <br/>"); 
			success = false; 
		} else {
			password_not_null = true; 
		}
		if(confirm == null || confirm.trim().length() == 0) {
			out.println("<font color=\"red\"> Please confirm your password </font> <br/>"); 
			success = false; 
		} else {
			confirm_not_null = true; 
		}
		if(confirm_not_null && password_not_null) {
			if(!password.equals(confirm)) {
				out.println("<font color=\"red\"> your password does not match </font> <br/>"); 
				success = false; 
			}
		}
		if(success) {
			session.setAttribute("success", true);
			session.setAttribute("user",username); 
			Connection conn = null; 
			PreparedStatement ps = null;
			PreparedStatement ps2 = null; 
			try {
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/user_info?user=root&password=root");
				ps = conn.prepareStatement("INSERT INTO usernames (username)" + "VALUES(?)");
				ps.setString(1,username);
				ps.executeUpdate();
				ps2 = conn.prepareStatement("INSERT INTO passwords (password)" + "VALUES(?)");
				ps2.setString(1,password);
				ps2.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				try {
					if(ps != null) {ps.close();}
					if(conn != null) {conn.close();}
				} catch(SQLException sqle) {
					System.out.println(sqle.getMessage());
				} 
			}
		} else {
			//session.setAttribute("success", false);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
