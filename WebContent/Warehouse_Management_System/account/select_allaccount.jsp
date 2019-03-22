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
		String username = (String)session.getAttribute("username");
		String authority = (String)session.getAttribute("authority");
		if(username==null){
			response.sendRedirect("../login.jsp");
		}else if(Integer.parseInt(authority)==0){
			response.sendRedirect("permission_denied.jsp");
		}
		
	%>
	欢迎您，<%=username %>   <a href="../invalidate.jsp">点这里注销！</a><br/>
	<h2>查询账户</h2>
	<%
		String URL = "jdbc:mysql://localhost:3306/hongqiaochen?serverTimezone=GMT";
		String USERNAME = "root";
		String PWD = "password";
		Statement stmt = null;
		Connection connection = null;
		ResultSet rs=null;
		int count = 0;
			try {
				//导入驱动，加载驱动类
				Class.forName("com.mysql.cj.jdbc.Driver");
				//与数据库建立连接
				connection = DriverManager.getConnection(URL,USERNAME,PWD);
				//发送sql,执行
				stmt= connection.createStatement();
				String sql1 = "select * from user ";
				rs = stmt.executeQuery(sql1);
				if(rs!=null){
					while(rs.next()) {
						int id = rs.getInt("id");
						String name = rs.getString("name");
						String pwd = rs.getString("pwd");
						String auth = rs.getString("authority");
						out.print(id+"--"+name+"--"+pwd+"--"+auth+"<br/>");
						count ++ ;
					}
				}
			}catch (ClassNotFoundException e) {
				e.printStackTrace();
			}catch (SQLException e) {
				e.printStackTrace();
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				try {
					if (rs!=null) rs.close();
					if (stmt!=null) stmt.close();
					if (connection!=null) connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
	%>
	共有<%=count %>个用户，<a href="../main.jsp">点击此处返回主页面</a>
</body>
</html>