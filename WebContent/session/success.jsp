<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% 
		String name = (String)session.getAttribute("uname");
		if(name==null){
			response.sendRedirect("login.jsp");
		}
	%>
	登陆成功！欢迎你：<%=name %>
	<a href="invalidate.jsp">点这里注销！</a>
	
</body>
</html>