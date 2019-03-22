<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="check.jsp" method="post">
		账号：<input type="text" name="username"/><br/>
		密码：<input type="password" name="userpwd"/><br/>
		权限：
		User<input type="radio" checked="checked" name="authority" value="0">
		Root<input type="radio" name="authority" value="1"><br/>
		<input type="submit" name="登陆"/>
	</form>
</body>
</html>