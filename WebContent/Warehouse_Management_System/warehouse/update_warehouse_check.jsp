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
	String id = request.getParameter("id");
	String length = request.getParameter("length");
	String width = request.getParameter("width");
	String heigth = request.getParameter("heigth");
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
			String sql1 = "select * from warehouse where id ='"+id+"'";
			String sql2 = "update warehouse set w_l='"+length+"'where id ='"+id+"'";
			String sql3 = "update warehouse set w_w='"+width+"' where id ='"+id+"'";
			String sql4 = "update warehouse set w_h='"+heigth+"' where id ='"+id+"'";
			rs = stmt.executeQuery(sql1);
			if (rs.next()) {
				int used = Integer.parseInt(rs.getString("used"));
				if (used==0){
					int count = stmt.executeUpdate(sql2);
					stmt.executeUpdate(sql3);
					stmt.executeUpdate(sql4);
					//处理结果集
					if(count>0) {
						response.sendRedirect("update_warehouse_success.jsp");
					}
				}else{
					response.sendRedirect("update_warehouse_error1.jsp");
				}
			}else {
				response.sendRedirect("update_warehouse_error2.jsp");
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