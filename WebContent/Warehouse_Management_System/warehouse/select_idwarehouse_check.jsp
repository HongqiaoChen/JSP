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
		}
	%>
	欢迎您，<%=username %>   <a href="../invalidate.jsp">点这里注销！</a>
	<br/>
	<h2>查询某一货仓的使用情况</h2>
	<%
		String id = request.getParameter("id");
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
				rs = stmt.executeQuery(sql1);
				if (rs.next()) {
					int w_l = rs.getInt("w_l");
					int w_d = rs.getInt("w_w");
					int w_h = rs.getInt("w_h");
					String goods =rs.getString("goods"); 
					int g_l = rs.getInt("g_l");
					int g_d = rs.getInt("g_w");
					int g_h = rs.getInt("g_h");
					int max = rs.getInt("max");
					int real = rs.getInt("r");
					Date date = rs.getDate("times");
					String used = rs.getString("used");
					String full = rs.getString("full");
					if(goods.equals("null") || goods==null){
						out.print("在"+id+"号货仓内暂时没有存放货物。<br/>");
					}else{
						out.print(id+"号货仓长为："+w_l+"cm，宽为"+w_d+"cm，高为"+w_h+"cm。在货仓内存有"+goods+"货物"+real+"件。它的入库时间是："+date+"。其所在货箱是否装满（1为装满，0为未满）："+full+"。<br/>");
					}
				}else {
					response.sendRedirect("select_idwarehouse_error.jsp");
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
	<a href="../main.jsp">点这里回到主页面！</a><br/>
</body>
</html>