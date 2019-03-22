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
		if(name.equals("hqc")&&pwd.equals("123")){
			//只有登陆成功，session中才会有
			session.setAttribute("uname", name);
			session.setAttribute("upwd", pwd);
			//Cookie cookie = new Cookie();
			//response.addCookie(cookie1);
			//session.setMaxInactiveInterval(10);
			request.getRequestDispatcher("success.jsp").forward(request, response);
			
		}else{
			//登陆失败
			response.sendRedirect("error.jsp");
		}
	%>
</body>
</html>