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
		String delname1 = request.getParameter("delname1");
		String delname2 = request.getParameter("delname2");

		if(delname1.equals(delname2)){
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
					String sql1 = "select * from warehouse where id='"+delname1+"'";
					String sql2 = "delete from warehouse where id='"+delname1+"'";
					rs = stmt.executeQuery(sql1);
					if (rs.next()) {
						int used = Integer.parseInt(rs.getString("used"));
						if (used==0){
							int count = stmt.executeUpdate(sql2);
							//处理结果集
							if(count>0) {
								response.sendRedirect("del_warehouse_success.jsp");
							}
						}else{
							response.sendRedirect("del_warehouse_error3.jsp");
						}
					}else {
						response.sendRedirect("del_warehouse_error2.jsp");
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
		}else{
			response.sendRedirect("del_warehouse_error1.jsp");
		}
		
	%>
</body>
</html>