<%@page language="java" pageEncoding="utf-8"%>
<html>
<%
	String path = request.getContextPath();
	String base = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	request.setAttribute("base", base);
%>
<head>

<script src="../resource/js/jquery.min.js" type="text/javascript"></script>
<script src="../thirdparty/ckeditor/ckeditor.js" type="text/javascript"></script>
<script src="../thirdparty/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
var show = false;

$(function() {
	init();
	$("#divShow").hover(function () {
		$(this).show();
		show = true;
	}, function () {
		$(this).hide();
		show = false;
	});
});

var regionList = null;
// 定义行政区域类
var Region = {
	createNew: function(){
		var region = {};
		region.code = "";
		region.name = "";
		region.spell = "";
		region.pinyin = "";
		//region.makeSound = function(){ alert("message"); };
		//region.sub = null;
		return region;
	}
};
// 从请求返回的json中重组行政区域类对象数据
function getRegionList(obj) {
	if (obj == null) {
		return null;
	}
	var list = new Array();
	$.each(obj, function (i, entry) {
		var temp = Region.createNew();
		temp.code = entry.regionCode;
		temp.name = entry.regionName;
		temp.spell = entry.spell;
		temp.pinyin = entry.pinyin;
		list.push(temp);
	});
	return list;
}
// 组装下拉列表框数据
function initSelectRegion() {
	if (regionList != null) {
		$.each(regionList, function (i, obj) {
			$("#showList").append('<li class=\"region_content_out\" id=\"' + obj.code 
					+ '\" onmouseover=\"mouseOver(this)\" onmouseout=\"mouseOut(this)\" onclick=\"regionSelected(this)\" ondblclick=\"selected(this)\">' 
					+ obj.name + "(" + obj.spell + ")" + '</li>');
		});
	}
}

function init() {
	var url = "${base}searchBox/getRegion";
	post(url, null, null, function(json) {
		if (json.result != '1') {
			alert(json.result);
		} else {
			if (json.list != null) {
				regionList = getRegionList(json.list);
			}
			initSelectRegion();
		}
	});
}

function post(url, data, opTip, callback) {
	$.ajax({type: "POST", url:url, data:data, success:function(json) {
		if (opTip != null) {
			alert(opTip);
		}
		callback.call(this, json);
	}, error:function(XMLHttpRequest, textStatus, errorThrown) {
		document.write("json " + textStatus + XMLHttpRequest.responseText);
	}});
}

function regionInput() {
	$('#divShow').hide();
	$('#showList').empty();
	initSelectRegion();
	var searchStr = $("#region").val();
	if (searchStr == "") {
		$("#regionCode").val("");
		$("#region").val("");
	} else {
		var flag = false;
		$.each(regionList, function (i, obj) {
			// 匹配区域名称、拼音首字母、拼音
			if (obj.name.indexOf(searchStr) >= 0 || obj.spell.indexOf(searchStr) >= 0 || obj.pinyin.indexOf(searchStr) >= 0) {
				$("#" + obj.code).show();
			} else {
				$("#" + obj.code).hide();
			}
			// 若当前输入框中的区域名称存在，则自动选择区域代码
			if (obj.name == searchStr) {
				$("#regionCode").val(obj.code);
			}
			// 判断当前输入框中的名称是否与区域代码匹配上
			var currentCode = $("#regionCode").val();
			if (obj.name == searchStr && currentCode == obj.code) {
				flag = true;
			}
		});
		// 若输入框中的名称与选择的区域代码对不上，可能是输入框中的名称选择后修改过，则清空选择的区域代码
		if (!flag) {
			$("#regionCode").val("");
		}
	}
	$('#divShow').show();
}

function closeRegion() {
	if (show) {
		;
	} else {
		$('#divShow').hide();
	}
}

function mouseOver(o) {
	$("#" + o.id).removeClass("region_content_out");
	$("#" + o.id).addClass("region_content_over");
}

function mouseOut(o) {
	$("#" + o.id).removeClass("region_content_over");
	$("#" + o.id).addClass("region_content_out");
}

function regionSelected(o) {
	$("#" + o.id).addClass("region_content_selected");
	$("#showList li[id!=" + o.id + "]").removeClass("region_content_selected");
}

function selected(o) {
	$("#regionCode").val(o.id);
	$.each(regionList, function (i, obj) {
		if (obj.code == o.id) {
			$("#region").val(obj.name);
		}
	});
	$('#divShow').hide();
}
</script>
<style type="text/css">
.region_content_out {
	font-size:12px;
	height:20px;
	background-color:#fdfdfd;
	border-bottom: 1px solid #CCCCCC;
	list-style-type: none;
}

.region_content_over {
	font-size:12px;
	height:20px;
	background-color:#FFE788;
	border-bottom: 1px solid #CCCCCC;
	list-style-type: none;
}

.region_content_selected {
	font-size:12px;
	height:20px;
	background-color:#FFE788;
	border-bottom: 1px solid #CCCCCC;
	list-style-type: none;
}

.list_region_content {
	height:20px;
	background-color:#999;
    border-bottom: 1px solid #CCCCCC;
}

.div_region {
	position: absolute;
	border: 1px solid #ccc;
	background-color:#fdfdfd;
	z-index: 999;
	width:200px;
	min-width:200px;
	max-width:250px;
	max-height:250px;
	overflow:auto;
	display: none;
}
</style>
</head>
	<body>
		<table border="1" cellspacing="0" cellpadding="0" align="center" width="50%">
			<tr>
				<td>选择地区：</td>
				<td>
					<div><input type="text" id="region" onclick="regionInput()" onfocus="regionInput()" onkeyup="regionInput()" onblur="closeRegion()" maxlength="20" style="width: 200px" />
					<input type="hidden" id="regionCode" value=""/></div>
					<div id="divShow" class="div_region"><ul id="showList" style="margin-left: 0px;"></ul></div>
				</td>
			</tr>
			<tr>
				<td colspan="2"><input type="button" value="提交" onclick="alert($('#regionCode').val());"/></td>
			</tr>
		</table>
	</body>
</html>