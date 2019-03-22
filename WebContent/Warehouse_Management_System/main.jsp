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
			response.sendRedirect("login.jsp");
		}
	%>
	欢迎您，<%=username %>   <a href="invalidate.jsp">点这里注销！</a>
	<h1>用户管理</h1>
	<h3><a href="account/add_account.jsp">增加账户</a><h3>
	<h3><a href="account/del_account.jsp">删除账户</a><h3>
	<h3><a href="account/select_allaccount.jsp">查询账户</a><h3>
	<h3><a href="account/update_account.jsp">更改密码</a><h3>
	<h1>货物类型管理</h1>
	<h3><a href="goods/add_goods.jsp">增加货物类型</a><h3>
	<h3><a href="goods/del_goods.jsp">删除货物类型</a><h3>
	<h3><a href="goods/update_goods.jsp">更改货物类型</a><h3>
	<h3><a href="goods/select_allgoods.jsp">查询所有货物类型</a><h3>
	<h3><a href="goods/select_idgoods.jsp">按货号查询货物类型</a><h3>
	<h1>仓库管理</h1>
	<h3><a href="warehouse/add_warehouse.jsp">增加货仓</a><h3>
	<h3><a href="warehouse/del_warehouse.jsp">删除货仓</a><h3>
	<h3><a href="warehouse/update_warehouse.jsp">更改货仓属性</a><h3>
	<h3><a href="warehouse/select_allwarehouse.jsp">查询所有货仓情况</a><h3>
	<h3><a href="warehouse/select_idwarehouse.jsp">查询某一货仓情况</a><h3>
	<h3><a href="warehouse/select_goodswarehouse.jsp">查询某一货物的放置情况</a><h3>
	<h3><a href="warehouse/input_warehouse.jsp">货物入库</a><h3>
	<h3><a href="warehouse/output_warehouse.jsp">货物出库</a><h3>


</body>
</html>