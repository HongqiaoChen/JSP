<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.DecimalFormat"%>

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
	<h2>货物入库</h2>
	<%
		String goods = request.getParameter("id");
		int num = Integer.parseInt(request.getParameter("num"));
		int g_l = 0;
		int g_w = 0;
		int g_h = 0;
		int count = 0;
		String URL = "jdbc:mysql://localhost:3306/hongqiaochen?serverTimezone=GMT";
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
		int[] max_arr=new int[10000];
		float[] rate_arr=new float[10000];
		int[] count_arr=new int[10000];
		int[] size_arr=new int[10000];
		int[] index_arr=new int[10000];
		int sum = 0;
		int real =0;
		int rest = 0;
		int total = 0;
		String zero = "0";
		String used = "0";
		String full = "0";
		java.util.Date  date=new java.util.Date();
		Timestamp timeStamp = new Timestamp(date.getTime());
		DecimalFormat df=new DecimalFormat("0.00000");
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
				String sql2 = "select * from warehouse where used='"+zero+"'";
				String sql3 = null;
				rs1 = stmt1.executeQuery(sql1);
				if (rs1.next()) {
					g_l = rs1.getInt("length");
					g_w = rs1.getInt("width");
					g_h = rs1.getInt("heigth");	
				}else{
					response.sendRedirect("input_warehouse_error1.jsp");
				}
				rs2 =stmt2.executeQuery(sql2);
				while(rs2.next()){
					id_arr[count] = rs2.getString("id");
					int w_l = rs2.getInt("w_l");
					int a = w_l/g_l;
					int w_w = rs2.getInt("w_w");
					int b = w_w/g_w;
					int w_h = rs2.getInt("w_h");
					int c = w_h/g_h;
					max_arr[count] = a*b*c;
					total = total+max_arr[count];
					int d = g_l*g_w*g_h*max_arr[count];
					int e = w_l*w_w*w_h;
					rate_arr[count]=Float.parseFloat(df.format((float)d/e));
					count_arr[count]=count;
					index_arr[count]=count;
					size_arr[count] = w_l*w_w*w_h;
					count++;
				}
				//满额占有率冒泡排序
				for(int i=0;i<count;i++){
					for(int j=0;j<count-1-i;j++){
						if(rate_arr[j]<(rate_arr[j+1])){
							float rate_t = rate_arr[j];
							rate_arr[j] = rate_arr[j+1];
							rate_arr[j+1]=rate_t;
							int temp_c = count_arr[j];
							count_arr[j]=count_arr[j+1];
							count_arr[j+1] = temp_c;		
						}
					}
				}
				//库房大小冒泡排序
				for(int i=0;i<count;i++){
					for(int j=0;j<count-1-i;j++){
						if(size_arr[j]<(size_arr[j+1])){
							int size_t = size_arr[j];
							size_arr[j] = size_arr[j+1];
							size_arr[j+1]=size_t;
							int temp_i = index_arr[j];
							index_arr[j]=index_arr[j+1];
							index_arr[j+1] = temp_i;		
						}
					}
				}
				if(total>=num){
					if(max_arr[index_arr[0]]>=num){
						//选个更小的
						int aa = 0;
						for(int i=0;i<count;i++){
							if(max_arr[index_arr[i]]<num){
								real = num;
								if(real == max_arr[index_arr[i-1]]){
									full ="1";
								}else{
									full ="0";
								}
								sql3 = "update warehouse set goods='"+goods+"',g_l='"+g_l+"',g_w='"+g_w+"',g_h='"+g_h+"',max='"+max_arr[index_arr[i-1]]+"',r='"+real+"',times='"+timeStamp+"',used='1',full='"+full+"' where id='"+id_arr[index_arr[i-1]]+"'";
								aa = stmt3.executeUpdate(sql3);
								out.print("1系统自动在仓库"+id_arr[index_arr[i-1]]+"中放入了数量为"+real+"的"+goods+"货物"+"<br/>");
								break;
							}
						}if(aa==0){
							int i = count;
							real = num;
							if(real == max_arr[index_arr[i-1]]){
								full ="1";
							}else{
								full ="0";
							}
							sql3 = "update warehouse set goods='"+goods+"',g_l='"+g_l+"',g_w='"+g_w+"',g_h='"+g_h+"',max='"+max_arr[index_arr[i-1]]+"',r='"+real+"',times='"+timeStamp+"',used='1',full='"+full+"' where id='"+id_arr[index_arr[i-1]]+"'";
							aa = stmt3.executeUpdate(sql3);
							out.print("1系统自动在仓库"+id_arr[index_arr[i-1]]+"中放入了数量为"+real+"的"+goods+"货物"+"<br/>");
						}
					}else{
						//按占比最高的入
						for(int i=0;i<count;i++){
							if(num>0){
								if(sum<num){
									if(sum+max_arr[count_arr[i]]<=num){
										real = max_arr[count_arr[i]];
										used = "1";
										full = "1";
										sql3 = "update warehouse set goods='"+goods+"',g_l='"+g_l+"',g_w='"+g_w+"',g_h='"+g_h+"',max='"+max_arr[count_arr[i]]+"',r='"+real+"',times='"+timeStamp+"',used='"+used+"',full='"+full+"' where id='"+id_arr[count_arr[i]]+"'";
										stmt3.executeUpdate(sql3);
										out.print("2系统自动在仓库"+id_arr[count_arr[i]]+"中放入了数量为"+real+"的"+goods+"货物"+"<br/>");
										sum = sum+real;
									}else{
										//按占比高的入之后,没入满的继续按更小库入
										int aaa = 0;
										real = num-sum;
										num = 0;
										for(int k=0;aaa==0;k++){
											if(max_arr[index_arr[k]]<real){		
												full = "0";
												used = "1";
												sql3 = "update warehouse set goods='"+goods+"',g_l='"+g_l+"',g_w='"+g_w+"',g_h='"+g_h+"',max='"+max_arr[index_arr[k-1]]+"',r='"+real+"',times='"+timeStamp+"',used='1',full='0' where id='"+id_arr[index_arr[k-1]]+"' and used='0'";
												aaa = stmt3.executeUpdate(sql3);
												if(aaa!=0){
													out.print("3系统自动在仓库"+id_arr[index_arr[k-1]]+"中放入了数量为"+real+"的"+goods+"货物"+"<br/>");
												}
											}
										}
									}
								}
							}
						}
					}
				}else{
					response.sendRedirect("input_warehouse_error2.jsp");
				}
				if(rest == 0){
					out.print("入库操作成功！");
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