<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ include file="../shared/taglib.jsp"%>

<html>

<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SVA APP demo</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<meta name="MobileOptimized" content="320">

<%@ include file="../shared/importCss.jsp"%>
<!-- BEGIN PAGE LEVEL PLUGIN STYLES -->
<link href="<c:url value='/plugins/jquery-chosen/chosen.css'/>"
	rel="stylesheet" type="text/css" />
<link href="<c:url value='/css/pages/statistic.css'/>" rel="stylesheet"
	type="text/css" />
<!-- END PAGE LEVEL PLUGIN STYLES -->
<style type="text/css">
</style>

<link rel="shortcut icon" href="favicon.ico" />
</head>
<!-- END HEAD -->

<!-- BEGIN BODY -->
<body class="page-header-fixed">

	<%@ include file="../shared/pageHeader.jsp"%>

	<div class="clearfix"></div>
	<!-- BEGIN CONTAINER -->
	<div class="page-container">

		<%@ include file="../shared/sidebarMenu.jsp"%>

		<!-- BEGIN PAGE -->
		<div class="page-content">

			<!-- BEGIN PAGE HEADER-->
			<div>
				<div>
					<!-- BEGIN PAGE TITLE & BREADCRUMB-->
					<ul class="page-breadcrumb breadcrumb">
						<li><i class="icon-home" style="background-image: none"></i>
							<spring:message code="menu_customer_analyse" /> <i
							class="icon-angle-right"></i></li>
						<li><spring:message code="menu_customer_analyse_heatmap" /></li>
					</ul>
					<!-- END PAGE TITLE & BREADCRUMB-->
				</div>
			</div>
			<!-- END PAGE HEADER-->

			<div class="row-fluid" style="border-bottom: 1px solid rgba(0, 0, 0, 0.1);margin-bottom:5%;">
				<form class="demoform" onkeydown= "if(event.keyCode==13)return false;">
					<div class="span2">
						<select id="marketSel" datatype="*"  nullmsg='<spring:message code="map_store_name" />' 
							data-placeholder="<spring:message code="heatmap_place" />"
							style="width: 30%" >
							<option value=""></option>
						</select> 
					</div>
					<div class="span2">
						<select id="floorSel" datatype="*"  nullmsg='<spring:message code="all_floor_choose" />' name="floorSelName"
							data-placeholder="<spring:message code="heatmap_floor" />"
							style="width: 30%" class="chosen-select">
							<option value=""></option>
						</select>
					</div>
					<div class="span4">
						<div class="input-append">
							<input id="select_time_begin_tab" style="width: 180px" readonly/> 
							<span class="add-on" onclick="Positionmap.showDate('select_time_begin_tab');">
								<i class="icon-calendar"></i>
							</span>
						</div>
						-
						<div class="input-append">
							<input id="select_time_end_tab" style="width: 180px" readonly/> 
							<span class="add-on" onclick="Positionmap.showDate('select_time_end_tab');"> 
								<i class="icon-calendar"></i>
							</span>
						</div>
					</div>
					<div class="span4">
						<input id="confirm" type="button"
						style="vertical-align: top; padding: 0px 3px 0px 4px; height: 22px" value="<spring:message code="common_confirm" />">
						
						<span  id="msgdemo2"></span>	
					</div>	
				</form>
			</div>
			<div id="mainContent" class="row-fluid">
				<div class="span6">
					<div class="row-fluid">
						<div id="barchart" style="height:500px;">
						</div>
					</div>
				</div>
				<div class="span6">
					<div class="row-fluid">
						<div id="mapchart" style="height:500px;"></div>
					</div>
				</div>
			</div>

		</div>
		<!-- END PAGE -->
	</div>
	<!-- END CONTAINER -->
	<!-- BEGIN FOOTER -->   
	<%@ include file="../shared/pageFooter.jsp"%>
	<!-- END FOOTER -->

	<%@ include file="../shared/importJs.jsp"%>
	<!-- BEGIN PAGE LEVEL SCRIPTS -->
	<script src="<c:url value='/plugins/jquery-chosen/chosen.jquery.js'/>"
		type="text/javascript"></script>
	<script
		src="<c:url value='/plugins/echarts3/echarts.min.js'/>"
		type="text/javascript"></script>
	<script
		src="<c:url value='/plugins/echarts3/china.js'/>"
		type="text/javascript"></script>
	<script src="<c:url value='/plugins/wDatePicker/WdatePicker.js'/>"
		type="text/javascript"></script>
	<script src="<c:url value='/js/app.js'/>" type="text/javascript"></script>
	<script src="<c:url value='/js/positionmap.js'/>" type="text/javascript"></script>
	<!-- END PAGE LEVEL SCRIPTS -->

	<script type="text/javascript">
	var i18n_delete = '<spring:message code="common_delete" />',
	    i18n_info = '<spring:message code="map_info" />',
	    i18n_time = '<spring:message code="linemap_time" />',
	    i18n_title = '<spring:message code="barmap_chart_title" />',
	    i18n_tag = '<spring:message code="barmap_chart_tag" />', 
	    i18n_max = '<spring:message code="linemap_chart_max" />', 
	    i18n_min = '<spring:message code="linemap_chart_min" />', 
	    i18n_avg = '<spring:message code="linemap_chart_avg" />',
	    i18n_dataview = '<spring:message code="common_echart_dataview" />',
	    i18n_close = '<spring:message code="common_close" />',
	    i18n_refresh = '<spring:message code="common_refresh" />',
	    i18n_saveimg = '<spring:message code="common_echart_saveimg" />',
	    i18n_language = '<spring:message code="time_language" />'; 
		
		jQuery(document).ready(function() {
			var validForm = $(".demoform").Validform({tiptype:3});
			App.init();
			Positionmap.initDropdown();
			Positionmap.bindClickEvent();
		});
	</script>
	<!-- END JAVASCRIPTS -->
</body>
</html>