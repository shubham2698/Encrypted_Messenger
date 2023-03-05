<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import=" java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.*" %>
<%@page import="javax.servlet.http.HttpServlet" %>
<%@page import="javax.servlet.http.HttpServletRequest"%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>receiver</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<style>
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
		.container{
			margin-top:10%;
			}
	</style>
</head>

<body>

<%
HttpSession session1=request.getSession(false);
String receiver_name=(String)session1.getAttribute("uname");
String encrypted_message= null;
%>
<iframe src="navbar.html" style="width:100%;height:70px;"></iframe>
		<a href="login.html" class="logout_b">Logout</a>
		<div class="container">
		
		<h2>Welcome <%=receiver_name%></h2>
			<nav aria-label="breadcrumb">
		  	<ol class="breadcrumb">
		    	<li class="breadcrumb-item"><a href="index.html">Home</a></li>
		    	<li class="breadcrumb-item active" aria-current="page">Receive</li>
		  	</ol>
			</nav>
		<table class="table table-fixed ">
		  <thead class="thead-dark">
		    <tr>
		      <th scope="col">#</th>
		      <th scope="col">Sender Name</th>
		      <th scope="col">Message</th>
		    </tr>
		  </thead>
		  <tbody>
  	  		<tr>

<%  
  


try {
	Class.forName("com.mysql.jdbc.Driver");
	String sql = "select * from messages where receiver_name=\""+receiver_name+"\"";
	
	
	Connection	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/user","root",""); 
	Statement stmt = con.createStatement();
 	ResultSet res = stmt.executeQuery(sql);
	
	 while(res.next()) {
	 
	encrypted_message = res.getString(4); 
		 
		    
%>
	 
      <th scope="row"><%=res.getString(1)%></th>
      <td><%=res.getString(2)%></td>
      <td><%=encrypted_message%></td>
    </tr>
  
<%
	 } 
		
	}
	catch(ClassNotFoundException cnfe) {
		cnfe.printStackTrace();
	}
%>
</tbody>
</table>
<form action="ReceiverServlet" method="post">
	<div class="decrypt_1" style="margin-top: 5%;">
		<div class="form-group">
			<label for="text">Enter Encrypted Message</label>
			<input type="text" class="form-control" id="exampleInputPassword1" placeholder="Enter Text Here" name="encrypted_msg"> 
		</div>
		
		<div class="text-center mt-2">
			<button type="submit" class="btn btn-primary" style="border-radius: 30px; width: 150px; height: 50px; font-size: 20px;">Decrypt</button>
		</div>
	</div>		
</form>
  	</div>

	<iframe src="footer.html"  style="width:100%;  margin-top: 15%;"></iframe>
</body>
</html>