package encrypt;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.*;


/**
 * Servlet implementation class Register
 */
@WebServlet("/Connector")
public class Connector extends HttpServlet {
	private static final long serialVersionUID = 1L;
	

    /**
     * Default constructor. 
     */
    public Connector() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("username");
		String pass = request.getParameter("password");
		PrintWriter out=response.getWriter();
		String pass_w = null;
		HttpSession session=request.getSession();  
        session.setAttribute("uname",name);
		
		
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String sql = "select password from user where username =\""+name+"\"";
			
			
			Connection	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/user","root",""); 
			Statement stmt = con.createStatement();
		 	ResultSet res = stmt.executeQuery(sql);
			
			while(res.next()) {
			pass_w = res.getString("password");
			
			
			}
		
			if(pass.equals(pass_w)) {	
				RequestDispatcher rd=request.getRequestDispatcher("index.html");
				rd.forward(request, response);
				
			}
			else {
				out.println("Username and Password Not Matched");
			}
			
		}
		catch(ClassNotFoundException cnfe) {
			cnfe.printStackTrace();
		}
			catch(SQLException sqle)
			{
				sqle.printStackTrace();
			}
		
		
	}
	
}

