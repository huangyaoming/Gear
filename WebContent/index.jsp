<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	String path = request.getContextPath();
	String base = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<p>这是首页。<a href="<%=base%>login/login">点击进入</a>
	<p><a href="<%=base%>datetime/show">日期时间控件</a>
	<p><a href="<%=base%>selecter/show">选择控件</a>
	<p><a href="<%=base%>searchBox/show">搜索输入框</a>
</body>
</html>