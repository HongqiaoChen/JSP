<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String name = request.getParameter("uname");
		String pwd = request.getParameter("upwd");
		if(name.equals("hqc")&&pwd.equals("123456")){
			//request.getRequestDispatcher("success.jsp").forward(request, response);//请求转发保留数据 
			response.sendRedirect("success.jsp");//重定向不保留数据
		}else{
			response.sendRedirect("error.jsp");
		}
	%>
</body>
</html>