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
	<h2>更改货物类型</h2>
		<form action="update_warehouse_check.jsp" method="post" onsubmit="return check()">	
		请输入要更改货物的货号：<input type="text" name="id" id="id"/><br/>
		请输入新的货物长度：<input type="text" name="length" id="length"><br/>
		请输入新的货物宽度：<input type="text" name="width" id="width"><br/>
		请输入新的货物高度：<input type="text" name="heigth" id="heigth"><br/>
		<input type="submit" value="提交"/>
	</form>
</body>
	<script>
		function check(){
			var x = document.getElementById("length").value;//获取input内元素
			var y = document.getElementById("width").value;
			var z = document.getElementById("heigth").value;
			if(x==""|| isNaN(x)){//进行数字校验，如果不是数字填出对话框进行提示
				alert("货箱长度必须为数字");
				return false;
			}
			if(y==""|| isNaN(y)){//进行数字校验，如果不是数字填出对话框进行提示
				alert("货箱宽度必须为数字");
				return false;
			}
			if(z==""|| isNaN(z)){//进行数字校验，如果不是数字填出对话框进行提示
				alert("货箱高度必须为数字");
				return false;
			}
			return true;
		}
	</script>
</html>