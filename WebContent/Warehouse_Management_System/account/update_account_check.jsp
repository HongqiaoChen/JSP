<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	String username =(String)session.getAttribute("username");
	String oldpwd1 = (String)session.getAttribute("userpwd");
	String oldpwd2 = request.getParameter("oldpwd");
	String newpwd1 = request.getParameter("newpwd1");
	String newpwd2 = request.getParameter("newpwd2");
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
			String sql = "update user set pwd='"+newpwd1+"' where name ='"+username+"'";
			if(oldpwd1.equals(oldpwd2)){
				if(newpwd1.equals(newpwd2)){
					int count = stmt.executeUpdate(sql);
					//处理结果集
					if(count>0) {
						response.sendRedirect("update_account_success.jsp");
					}
				}else{
					response.sendRedirect("update_account_error2.jsp");
				}
			}else{
				response.sendRedirect("update_account_error1.jsp");
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