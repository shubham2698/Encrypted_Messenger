<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.SQLException" %>
<%@page import= "javax.servlet.http.HttpSession" %>
<%@page import="java.sql.Connection" %>
<%@page import=" java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.*" %>
<%@page import="javax.servlet.http.HttpServlet" %>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="java.io.PrintWriter"%>

<%@page import="encrypt.RSA" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>sender_page</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"  >
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"  ></script>
	<style type="text/css">
		.container{
			margin-right: 10%;

		}
		.text-box{
			width: 100%;
			margin-left: 10%;
			margin-top: 5%;
		}
		.form-group{

			width: 50%;
			margin-left: 10%;
			margin-top: 5%;
		}
		.main{
			margin-top:10%;
			display: flex;
			flex-direction: row;
		}
		.receiver{
			width: 30%;
		}.form-group{
			width: 100%;
		}
		.logout_b{
			float:right;
			margin-top:0px;
			margin-right:30px;
			border : 1px solid red;
			border-radius:10px;
			text-decoration:none;
			padding:7px;
			color:black;
		}
		.logout_b:hover{
			background-color:red;
			color:white;		
		}
	</style>
</head>
<body>
<% 
HttpSession session1=request.getSession(false);
String sender_name=(String)session1.getAttribute("uname");
String message=request.getParameter("message");
String receiver_name=request.getParameter("receiver_name");
RSA obj =new RSA();
try {
	obj.initFromStrings();
	message = obj.encrypt(message);
  } catch (Exception e1) {
	// TODO Auto-generated catch block
	e1.printStackTrace();
  }
try {
	Class.forName("com.mysql.jdbc.Driver");
	 Connection con =DriverManager.getConnection("jdbc:mysql://localhost:3306/user","root","");
	 if (con!=null) {
		 System.out.println("Connection Succesfully");
	 }
		
		  PreparedStatement pst=con.prepareStatement("insert into messages values(?,?,?,?)");
		  pst.setString(1,null); 
		  pst.setString(2,sender_name);
		  pst.setString(3,receiver_name);
		  pst.setString(4,message); 
		  int row =pst.executeUpdate();
		  		 
} catch (ClassNotFoundException | SQLException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}			




%>
<iframe src="navbar.html" style="width:100%;height:70px;"></iframe>
	<a href="login.html" class="logout_b">Logout</a>
	<div class="main">
		<div class="container">
			<h2 style="margin-left:100px;">Welcome <%=sender_name%></h2>
			<nav style="margin-left:100px; aria-label="breadcrumb">
		  	<ol class="breadcrumb">
		    	<li class="breadcrumb-item"><a href="index.html">Home</a></li>
		    	<li class="breadcrumb-item active" aria-current="page">Send</li>
		  	</ol>
			</nav>
		<form  method="post">	
		<div class="text-box" >
			<div class="input-group" >
				<textarea class="form-control" aria-label="With textarea" placeholder="Enter Your text here...!!!"  name="message"style="height:150px;"></textarea>
			</div>

		</div><br>
		<div class="text-center">
			<h1>OR</h1>
		</div><br>
			 
		<div class="form-group">
			<label for="exampleFormControlSelect1">Choose Encryption Algorithm</label>
				<select class="form-control" id="exampleFormControlSelect1">
					<option>RSA</option>
				</select>
			
			<div class="text-center mt-2">
				<button type="submit" class="btn btn-primary" style="border-radius: 30px; width: 150px; height: 50px; font-size: 20px;">Send</button>
			</div>
        </div><br>
		
	
  	</div>
	  <div class="receiver">
	  	<h4>Select Receiver</h4>
	 <%
	  	try {
			Class.forName("com.mysql.jdbc.Driver");
			String sql = "select username from user";			
			Connection	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/user","root",""); 
			Statement stmt = con.createStatement();
		 	ResultSet ress = stmt.executeQuery(sql);
			
			 while(ress.next()) {	
				 StringBuffer sender_name_for_value = new StringBuffer(ress.getString("username"));
%>
	  	<div class="form-check">
  		<input class="form-check-input" type="checkbox" value="<%=sender_name_for_value%>" name="receiver_name" id="receiver_name">
  		<label class="form-check-label" for="receiver_name"><%=ress.getString("username")%></label>
		</div>
		<%
	 } 
		
	}
	catch(ClassNotFoundException cnfe) {
		cnfe.printStackTrace();
	}
%>
		</div>
  </div>
  </form>
  
  <iframe src="footer.html"  style="width:100%;  margin-top: 15%;"></iframe>
</body>
</html>