<%@page language="java" pageEncoding="utf-8"%>
<html>
<%
	StringBuffer sb = new StringBuffer("<table align=\"center\" width=\"98%\">");
	sb.append("</table>");
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
	jQuery("#showList").hover(function () {
		jQuery(this).show();
		show = true;
	}, function () {
		jQuery(this).hide();
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
		//region.makeSound = function(){ alert("喵喵喵"); };
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
		list.push(temp);
	});
	return list;
}
// 组装下拉列表框数据
function initSelectRegion() {
	if (regionList != null) {
		$.each(regionList, function (i, obj) {
			$("#showTable").append('<tr class=\"list_region_content\"><td align=\"center\" class=\"region_content_out\" id=\"' + obj.code 
					+ '\" onmouseover=\"mouseOver(this)\" onmouseout=\"mouseOut(this)\" onclick=\"regionSelected(this)\" ondblclick=\"selected(this)\">' 
					+ obj.name + '</td></tr>');
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
	var searchStr = jQuery("#region").val();
	if (searchStr == "") {
		jQuery("#regionCode").val("");
		jQuery("#region").val("");
	} else {
		jQuery('#showList').show();
	}
	jQuery('#showList').show();
}

function closeRegion() {
	if (show) {
		;
	} else {
		jQuery('#showList').hide();
	}
}

function mouseOver(o) {
	jQuery("#" + o.id).removeClass("region_content_out");
	jQuery("#" + o.id).addClass("region_content_over");
}

function mouseOut(o) {
	jQuery("#" + o.id).removeClass("region_content_over");
	jQuery("#" + o.id).addClass("region_content_out");
}

function regionSelected(o) {
	jQuery("#" + o.id).addClass("region_content_selected");
	jQuery("#showTable tr td[id!=" + o.id + "]").removeClass("region_content_selected");
}

function selected(o) {
	jQuery("#regionCode").val(o.id);
	var str = jQuery("#" + o.id).html();
	jQuery("#region").val(str);
	jQuery('#showList').hide();
}
</script>
<style type="text/css">
.region_content_out {
	font-size:12px;
	background-color:#fdfdfd;
	border-bottom: 1px solid #CCCCCC;
}

.region_content_over {
	font-size:12px;
	background-color:#FFE788;
	border-bottom: 1px solid #CCCCCC;
}

.region_content_selected {
	font-size:12px;
	background-color:#FFE788;
	border-bottom: 1px solid #CCCCCC;
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
	min-width:100px;
	max-width:150px;
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
					<div><input type="text" id="region" onfocus="regionInput()" onkeyup="regionInput()" onblur="closeRegion()" maxlength="20"/>
					<input type="hidden" id="regionCode"/></div>
					<div id="showList" class="div_region"><table id="showTable" align="center" width="98%"><tr><td></td></tr></table></div>
				</td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit"" value="提交"/></td>
			</tr>
		</table>
	</body>
</html>