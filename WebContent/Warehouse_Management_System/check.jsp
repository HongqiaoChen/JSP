<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	String username = request.getParameter("username");
	String userpwd = request.getParameter("userpwd");
	String authority = request.getParameter("authority");
	String URL = "jdbc:mysql://localhost:3306/hongqiaochen?serverTimezone=GMT";
	String USERNAME = "root";
	String PWD = "password";
	Statement stmt = null;
	Connection connection = null;
	ResultSet rs=null;
		try {
			//导入驱动，加载驱动类
			Class.forName("com.mysql.cj.jdbc.Driver");
			//与数据库建立连接
			connection = DriverManager.getConnection(URL,USERNAME,PWD);
			//发送sql,执行
			stmt= connection.createStatement();
			String sql = "select * from user where name='"+username+"'and pwd='"+userpwd+"'and authority='"+authority+"'";
			rs = stmt.executeQuery(sql);
			//处理结果集
			int count =-1;
			if(rs.next()) {
				count = rs.getInt(1);
				session.setAttribute("username",username);
				session.setAttribute("userpwd",userpwd);
				session.setAttribute("authority",authority);
				request.getRequestDispatcher("main.jsp").forward(request, response);

			}else{
				count = 0;
				response.sendRedirect("login_error.jsp");
			}
		}catch (ClassNotFoundException e) {
			e.printStackTrace();
		}catch (SQLException e) {
			e.printStackTrace();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if (stmt!=null) stmt.close();
				if (connection!=null) connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	%>
</body>
</html>