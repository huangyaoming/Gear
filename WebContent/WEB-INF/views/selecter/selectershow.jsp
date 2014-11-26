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
$(function() {
	//init();
	//init2();
	init3();
});

var regionTree = null;
// 定义行政区域类
var Region = {
	createNew: function(){
		var region = {};
		region.code = "";
		region.name = "";
		//region.makeSound = function(){ alert("喵喵喵"); };
		region.sub = null;
		return region;
	}
};
// 从请求返回的json中重组行政区域类对象数据
function getRegion(obj) {
	if (obj == null) {
		return null;
	}
	var region = Region.createNew();
	region.code = obj.regionCode;
	region.name = obj.regionName;
	if (obj.subRegion != null) {
		region.sub = new Array();
		$.each(obj.subRegion, function (i, son) {
			//alert(son.regionCode + "---" + son.regionName);
			var temp = getRegion(son);
			region.sub.push(temp);
		});
	}
	return region;
}
// 循环遍历行政区域类对象
function showRegion(obj) {
	if (obj != null) {
		alert(obj.code + "+++" + obj.name);
		if (obj.sub != null && obj.sub.length > 0) {
			$.each(obj.sub, function (i, son) {
				showRegion(son);
			});
		}
	}
}
// 组装下拉列表框数据
function initSelectRegion() {
	if (regionTree != null) {
		$.each(regionTree.sub, function (i, son) {
			$("#country").append('<option value="' + son.code + '" label="' + son.name + '">' + son.name + '</option>');
		});
	}
}

function init3() {
	var url = "${base}searchBox/getRegion";
	post(url, null, null, function(json) {
		if (json.result != '1') {
			alert(json.result);
		} else {
			if (json.entry != null) {
				regionTree = getRegion(json.entry);
			}
			//showRegion(regionTree);
			initSelectRegion();
		}
	});
}

// 选择改变时，相应的联动改变其下属的选择项
function changeRegion(obj) {
	//alert($(obj).val());
	//alert($(obj).find('option:selected').text());	// 该方法需要<option></option>中间要有文本
	//alert($(obj).find('option:selected').attr("value"));
	//alert($(obj).find('option:selected').attr("label"));
	var objId = $(obj).attr("id");
	if (objId == "country") {
		$("#province").empty();
		$("#province").append('<option label="-----请选择-----" value="0"></option>');
		var selectedcode = $(obj).val();
		var parent = searchPatch(regionTree, selectedcode);
		if (parent != null && parent.sub != null) {
			$.each(parent.sub, function (i, son) {
				$("#province").append('<option value="' + son.code + '" label="' + son.name + '">' + son.name + '</option>');
			});
		}
		$("#city").empty();
		$("#city").append('<option label="-----请选择-----" value="0"></option>');
	} else if (objId == "province") {
		$("#city").empty();
		$("#city").append('<option label="-----请选择-----" value="0"></option>');
		var selectedcode = $(obj).val();
		var parent = searchPatch(regionTree, selectedcode);
		if (parent != null && parent.sub != null) {
			$.each(parent.sub, function (i, son) {
				$("#city").append('<option value="' + son.code + '" label="' + son.name + '">' + son.name + '</option>');
			});
		}
	} else if (objId = "city") {
		alert($("#country").val() + " " + $("#province").val() + " " + $("#city").val());
	}
}

function searchPatch(obj, searchcode) {
	if (obj != null) {
		if (obj.code != searchcode) {
			if (obj.sub != null) {
				var result = null;
				for (var j = 0; j < obj.sub.length; j++) {
					result = searchPatch(obj.sub[j], searchcode);
					if (result != null) {
						break;
					}
				}
				return result;
			}
		} else {
			return obj;
		}
	} else {
		return null;
	}
}

function init2() {
	var url = "${base}searchBox/getRegion";
	post(url, null, null, function(json) {
		if (json.result != '1') {
			alert(json.result);
		} else {
			alert(json.entry.regionCode + "---" + json.entry.regionName);
			$.each(json.entry.subRegion, function (i, obj) {
				alert(obj.regionCode + "---" + obj.regionName);
				if (obj.subRegion != null) {
					$.each(obj.subRegion, function (i, sub) {
						alert(obj.regionCode + "---" + obj.regionName);
					});
				} else {
					alert(obj.regionCode + " next is null.");
				}
			});
		}
	});
}

function init() {
	var url = "${base}searchBox/getInitData";
	post(url, null, null, function(json) {
		if (json.result != '1') {
			alert(json.result);
		} else {
			$.each(json.list[0], function (i, obj) {
				$.each(obj, function (j, map) {
					alert(map);
				});
			});
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
</script>
<style type="text/css">
.station_content_out {
	font-size:12px;
	background-color:#fdfdfd;
	border-bottom: 1px solid #CCCCCC;
}

.station_content_over {
	font-size:12px;
	background-color:#FFE788;
	border-bottom: 1px solid #CCCCCC;
}

.station_content_selected {
	font-size:12px;
	background-color:#FFE788;
	border-bottom: 1px solid #CCCCCC;
}

.list_station_content {
	height:20px;
	background-color:#999;
    border-bottom: 1px solid #CCCCCC;
}

.div_station {
	position: absolute;
	border: 1px solid #ccc;
	background-color:#fdfdfd;
	z-index: 999;
	min-width:200px;
	max-width:300px;
	max-height:250px;
	overflow:auto;
	display: none;
}
</style>
</head>
	<body>
		<table border="1" cellspacing="0" cellpadding="0" align="center" width="50%">
			<tr>
				<td>国家地区：</td>
				<td>
					<select name="country" id="country" onchange="changeRegion(this)">
						<option label="-----请选择-----" value="0"></option>
					</select>
				</td>
			</tr>
			<tr>
				<td>省市</td>
				<td>
					<select name="province" id="province" onchange="changeRegion(this)">
						<option label="-----请选择-----" value="0"></option>
					</select>
				</td>
			</tr>
			<tr>
				<td>市县</td>
				<td>
					<select name="city" id="city" onchange="changeRegion(this)">
						<option label="-----请选择-----" value="0"></option>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit"" value="提交"/></td>
			</tr>
		</table>
	</body>
</html>