<%@page language="java" pageEncoding="utf-8"%>
<html>
<%
	String path = request.getContextPath();
	String base = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<head>
<script src="../resource/js/jquery.min.js" type="text/javascript"></script>
<script src="../thirdparty/ckeditor/ckeditor.js" type="text/javascript"></script>
<script src="../thirdparty/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
$(function () {
	init();
});

var nowDate = new Date();
var afterDate = new Date();
afterDate.setDate(afterDate.getDate() + 5);

function init() {
	$("#year").change(flushDay);
	$("#month").change(flushDay);
	Statistic.InitYearSelect();
	Statistic.InitMonthSelect();
	Statistic.InitData();
}

Statistic = {};
Statistic.date = new Date();
Statistic.MonthDays = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];
Statistic.CurrYear = function() {
	return this.date.getFullYear().toString();
};

Statistic.CurrMonth = function() {
	return this.date.getMonth();
};

Statistic.CurrDay = function() {
	return this.date.getDate();
};

Statistic.InitYearSelect = function() {
	var years = this.CurrYear();
	for ( var i = years - 10; i <= years; i++) {
		$("#year").get(0).options.add(new Option(i, i));
	}
};

Statistic.InitMonthSelect = function() {
	for ( var i = 1; i < 13; i++) {
		$("#month").get(0).options.add(new Option(i, i));
	}
};

Statistic.InitData = function() {
	$("#year").val(this.CurrYear());
	$("#month").val(this.CurrMonth() + 1);
	flushDay();
	$("#day").val(this.CurrDay());
};

function flushDay() {
	var year = $("#year");
	var month = $("#month");
	var day = $("#day");
	var mn = month.val();
	var ye = year.val();
	var n = Statistic.MonthDays[mn - 1];
	day.empty();
	if (ye % 4 == 0 && mn == 2) {
		n++;
	}
	for ( var i = 1; i < n + 1; i++) {
		day.get(0).options.add(new Option(i, i));
	}
}

function submitDate() {
	$("input[name='year']").val($("#year").val());
	$("input[name='month']").val($("#month").val());
	$("input[name='day']").val($("#day").val());
	$("#dateForm").submit();
}

function submitDatetime() {
	$("#datetimeForm").submit();
}
</script>
</head>
<body>
	<h3>Datetime Show</h3>
	<form id="dateForm" action="<%=base %>datetime/getDate">
		<table>
			<tr>
				<td>下拉式日期框：</td>
				<td><select id="year"></select>年</td>
				<td><select id="month"></select>月</td>
				<td><select id="day"></select>日</td>
			</tr>
			<tr>
				<td colspan="2"><input type="button" onclick="submitDate()" value="提交"/></td>
			</tr>
		</table>
		<input type="hidden" name="year"/>
		<input type="hidden" name="month"/>
		<input type="hidden" name="day"/>
	</form>
	<form id="datetimeForm" action="<%=base %>datetime/getDatetime">
		<table>
			<tr>
				<td>选择式日期框</td>
			</tr>
			<tr>
				<td>开始日期:<input type="text" id="startDate" name="startDate" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/></td>
				<td>结束日期:<input type="text" id="endDate" name="endDate" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/></td>
			</tr>
			<tr>
				<td>只能选择一个日期范围内的：<input type="text" id="chooseDate" name="chooseDate" class="Wdate" 
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:nowDate,maxDate:afterDate})"/></td>
			</tr>
			<tr>
				<td colspan="2"><input type="button" onclick="submitDatetime()" value="提交"/></td>
			</tr>
		</table>
	</form>
</body>
</html>