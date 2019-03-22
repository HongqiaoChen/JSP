<%@page import="java.awt.print.Printable"%>
<%@page import="javax.swing.RepaintManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>

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
	欢迎您，<%=username %>   <a href="../invalidate.jsp">点这里注销！</a><br/>
	<h2>货物出库</h2>
	<%
		String goods = request.getParameter("id");
		int num = Integer.parseInt(request.getParameter("num"));
		int g_l = 0;
		int g_w = 0;
		int g_h = 0;
		int count = 0;
		String URL = "jdbc:mysql://localhost:3306/hongqiaochen?useTimezone=true&serverTimezone=GMT%2B8";
		String USERNAME = "root";
		String PWD = "password";
		Statement stmt1 = null;
		Statement stmt2 = null;
		Statement stmt3 = null;
		Statement stmt4 = null;
		Connection connection = null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		ResultSet rs4=null;
		String[] id_arr = new String[10000];
		String[] used_arr = new String[10000];
		String[] full_arr = new String[10000];
		Timestamp[] times_arr = new Timestamp[10000];
		int[] notfull_index = new int[10000];
		int[] r_arr=new int[10000];
		int[] count_arr = new int[10000];
		int sum = 0;
		int real =0;
		int c = 0;
		int total = 0;
		int r = 0;
		int aaa = 0;
		String zero = "0";
		String used = "0";
		String full = "0";
		java.util.Date  date=new java.util.Date();
		Timestamp timeStamp = new Timestamp(date.getTime());

			try {
				//导入驱动，加载驱动类
				Class.forName("com.mysql.cj.jdbc.Driver");
				//与数据库建立连接
				connection = DriverManager.getConnection(URL,USERNAME,PWD);
				//发送sql,执行
				stmt1= connection.createStatement();
				stmt2= connection.createStatement();
				stmt3= connection.createStatement();
				stmt4= connection.createStatement();
				String sql1 = "select * from goods where id='"+goods+"'";
				String sql2 = "select * from warehouse where goods='"+goods+"'";

				rs1 = stmt1.executeQuery(sql1);
				if (rs1.next()) {
					rs2 =stmt2.executeQuery(sql2);
					while(rs2.next()){
						id_arr[count] = rs2.getString("id");	
						r_arr[count] = rs2.getInt("r");
						used_arr[count] = rs2.getString("used");
						full_arr[count] = rs2.getString("full");
						
						if(full_arr[count].equals("0")){
							notfull_index[c] = count;
							c++;
						}
						times_arr[count] = rs2.getTimestamp("times");
						count_arr[count] = count;
						sum = sum+r_arr[count];
						count++;

					}
					
					if(sum>=num){
						//先出没有满的
						for(int j=0;j<c;j++){
							if(total<num){
								if((total+r_arr[notfull_index[j]])<=num){
									
									String sql3 = "update warehouse set goods='null',g_l='0',g_w='0',g_h='0',max='0',r='0',times='1900-01-01 00:00:00.000',used='0',full='0' where id='"+id_arr[notfull_index[j]]+"'";
									int t = stmt3.executeUpdate(sql3);
									total = total+r_arr[notfull_index[j]];
									out.print("从"+id_arr[notfull_index[j]]+"号货箱出货"+r_arr[notfull_index[j]]+"件，该货箱已空！"+"<br/>");
								}else{
									r = total+r_arr[notfull_index[j]]-num;
									String sql3 = "update warehouse set r='"+r+"',used='1',full='0' where id='"+id_arr[notfull_index[j]]+"'";
									stmt3.executeUpdate(sql3);
									total = num;
									out.print("从"+id_arr[notfull_index[j]]+"号货箱出货"+(r_arr[notfull_index[j]]-r)+"件，还剩余"+r+"件在原货仓中！"+"<br/>");
								}
							}
						}
						//再出时间考前的
						for(int i=0;i<count;i++){
							for(int j=0;j<count-1-i;j++){
								if(times_arr[j].after(times_arr[j+1])){
									Timestamp temp=times_arr[j];
									times_arr[j]=times_arr[j+1];
									times_arr[j+1]=temp;
									int temp_c = count_arr[j];
									count_arr[j]=count_arr[j+1];
									count_arr[j+1] = temp_c;		
								}
							}
						} 
						for(int k=0;k<count;k++){
							if(total<num){
								if((total+r_arr[k])<=num){
									String sql4 = "update warehouse set goods='null',g_l='0',g_w='0',g_h='0',max='0',r='0',times='1900-01-01 00:00:00.000',used='0',full='0' where id='"+id_arr[count_arr[k]]+"' and full='1'";
									aaa = stmt4.executeUpdate(sql4);
									if(aaa>0){
										total = total+r_arr[k];
										out.print("从"+id_arr[count_arr[k]]+"号货箱出货"+r_arr[k]+"件，该货箱已空！"+"<br/>");
									}
									
								}else{
									r=total+ r_arr[k]-num;
									String sql4 = "update warehouse set r='0',r='"+r+"',used='1',full='0' where id='"+id_arr[count_arr[k]]+"' and full='1'";
									aaa = stmt4.executeUpdate(sql4);
									if(aaa>0){
										total = num;
										out.print("从"+id_arr[count_arr[k]]+"号货箱出货"+(r_arr[k]-r)+"件，还剩余"+r+"件在原货仓中！"+"<br/>");
									}
								}
							}
						}
					}else{
						response.sendRedirect("output_warehouse_error2.jsp");
					}		
				}else{
					response.sendRedirect("output_warehouse_error1.jsp");
				}
				out.print("当前仓库使用情况如下："+"<br/>");
				String sql4 = "select * from warehouse";
				rs4 = stmt4.executeQuery(sql4);
				if(rs4!=null){
					while(rs4.next()) {
						String id = rs4.getString("id");
						int w_l = rs4.getInt("w_l");
						int w_w = rs4.getInt("w_w");
						int w_h = rs4.getInt("w_h");
						goods =rs4.getString("goods"); 
						g_l = rs4.getInt("g_l");
						g_w = rs4.getInt("g_w");
						g_h = rs4.getInt("g_h");
						int max = rs4.getInt("max");
						real = rs4.getInt("r");
						date = rs4.getDate("times");
						used = rs4.getString("used");
						full = rs4.getString("full");
						out.print(id+"--"+w_l+"--"+w_w+"--"+w_h+"--"+goods+"--"+g_l+"--"+g_w+"--"+g_h+"--"+max+"--"+real+"--"+date+"--"+used+"--"+full+"<br/>");
						count ++ ;
					}
				}
			}catch (ClassNotFoundException e) {
				e.printStackTrace();
			}catch (SQLException e) {
				e.printStackTrace();
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				try {	
					if (stmt1!=null) stmt1.close();
					if (stmt2!=null) stmt1.close();
					if (stmt3!=null) stmt1.close();
					if (connection!=null) connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
	%>
	<a href="../main.jsp">点此返回主界面</a>
</body>
</html>