package cs201_hw3;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class profile_server
 */
@WebServlet("/profile_server")
public class profile_server extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public profile_server() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		response.getWriter().append("Served at: ").append(request.getContextPath());
		String user = (String)session.getAttribute("user");
		ResultSet rs = null; 
		ResultSet rs2 = null; 
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
			System.out.println("we found this userID " + userID); 
			ps2 = conn.prepareStatement("SELECT * FROM user_info.histories WHERE userID=?");
			ps2.setInt(1,userID);  
			rs2 = ps2.executeQuery();
			ArrayList<String> search_history = new ArrayList<String>();
			while(rs2.next()) {
				 search_history.add(rs2.getString("history")); 
			}
			Collections.reverse(search_history);
			session.setAttribute("search_history", search_history);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace(); 
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
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/profile.jsp");
		dispatch.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
