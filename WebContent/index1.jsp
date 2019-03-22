<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.util.Date"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<%!
		public String bookName;
		Date date = new Date();
		public void init(){
			bookName = "Python"+date;
		}
	%>
	<!-- html -->
	<%--jsp --%>
	index1 你好！
	<%
		String name = "hongqiaochen";
		out.print("hello"+"<br/>"+name);

		init();
	%>
	
	<%=bookName+"&nbsp"+name%>
	
</body>
</html>