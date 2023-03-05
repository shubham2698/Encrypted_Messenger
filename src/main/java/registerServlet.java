

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class registerServlet
 */
@WebServlet(description = "Used For Register new users", urlPatterns = { "/registerServlet" })
public class registerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public registerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stubPrintWriter out = response.getWriter();
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String username_in=request.getParameter("username"); 
		String emailid_in=request.getParameter("emailid");
		String  password_in=request.getParameter("password");
		String cnf_password_in=request.getParameter("cnf_pass");
		
		
		try {
			
			 Class.forName("com.mysql.jdbc.Driver");
			 Connection con =DriverManager.getConnection("jdbc:mysql://localhost:3306/user","root","");
			 if (con!=null) {
				 System.out.println("Connection Succesfully");
			 }
			 		  if(!password_in.equals(cnf_password_in)) {
			 			 out.println("<h1>Password Not Matched</h1>");
			 			 return;
			 		  }
			 		 // out.print(username_in+" "+emailid_in+" "+""+password_in+""+cnf_password_in);
			  		  PreparedStatement pst=con.prepareStatement("insert into user values(?,?,?,?,?)");
			  		  pst.setString(1,null);
					  pst.setString(2,username_in);
					  pst.setString(3,emailid_in);
					  pst.setString(4,password_in);
					  pst.setString(5,cnf_password_in);
					  int row =pst.executeUpdate(); 
					  out.print(username_in);
					  out.println("<h1>"+row+" User Registered Succesfully");
	
		}catch(Exception e) {
			out.println(e);
		}
		
	}
	}

