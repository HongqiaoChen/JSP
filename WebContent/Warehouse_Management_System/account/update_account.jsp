<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
	<a href="../main.jsp">点这里回到主页面！</a>
	<h2>更改密码</h2>
	<form action="update_account_check.jsp" method="post">	
		请输入原密码：<input type="password" name="oldpwd"/><br/>
		请输入新密码：<input type="password" name="newpwd1"><br/>
		请确认新密码：<input type="password" name="newpwd2"><br/>
		<input type="submit" value="提交"/>
	</form>
</body>
</html>