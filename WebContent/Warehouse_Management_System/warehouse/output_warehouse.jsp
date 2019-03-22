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
	
	<h2>货物出库</h2>
	<form action="output_warehouse_check.jsp" method="post" onsubmit="return check()">	
		请输入货号：<input type="text" name="id" id="id"/><br/>
		请输入数量：<input type="text" name="num" id="num"><br/>
		<input type="submit" name="确定"/>
	</form>
</body>
	<script>
		function check(){
			var x = document.getElementById("num").value;//获取input内元素
			if(x==""|| isNaN(x)){//进行数字校验，如果不是数字填出对话框进行提示
				alert("货物数量必须为数字");
				return false;
			}
			return true;
		}
	</script>
</html>