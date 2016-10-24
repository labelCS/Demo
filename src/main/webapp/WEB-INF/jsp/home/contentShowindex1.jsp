<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ include file="../shared/taglib.jsp"%>

<html>

<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if IE 11]> <html lang="en" class="ie11 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
<meta charset="utf-8">
<title>Small Cell City</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<link href="<c:url value='../plugins/html/css/minnew1.css'/>"
	rel="stylesheet" type="text/css" />
<link href="<c:url value='/css/pages/heatmap1.css'/>" rel="stylesheet"
	type="text/css" />
<script src="<c:url value='../plugins/html/js/jquery-2.1.3.min.js'/>"></script>
<script src="<c:url value='../plugins/html/js/swiper.min.js'/>"></script>
<script src="<c:url value='../plugins/html/js/json.js'/>"></script>
<script src="<c:url value='/js/appcontent1.js'/>"></script>
<!-- <script src="<c:url value='../plugins/html/js/appcontent.js'/>"></script>-->
<script src="<c:url value='/js/contentshowindex1.js'/>"
	type="text/javascript"></script>
<script src="<c:url value='../plugins/heatmap.min.js'/>"
	type="text/javascript"></script>
<script src="<c:url value='../plugins/underscore/underscore-min.js'/>"
	type="text/javascript"></script>
</head>
<body>
<!-- Swiper -->
<div class="swiper-container">
  <div class="swiper-wrapper">
    <div class="swiper-slide" id="huawei">
      <div class="slide-box">
       <!--<header>SERVICE ANCHOR:<span> DIGITAL FOOTPRINT ANALYSIS SOLUTION</span></header>-->
       <header>&nbsp;</header>
       <div class="numbern-data-list">
        <ul>
         <li><span id="numbern-data-item1"></span><span class="numbern-data-item">Current Visitor Number</span></li>
         <li><span id="numbern-data-item2"></span><span class="numbern-data-item">Cumulative Visitor Number</span></li>
         <li><span id="numbern-data-item3"></span><span class="numbern-data-item">Average Visit Time(Min)</span></li>
        </ul>
       </div>
       <div class="clear"></div>
       <div class="heatmap-slide1">
        <h2>Huawei Exhibition Hall</h2>
        <div id="heatmap-slide1-graphic">
          <!--  热力图大小： width:1006px; height:630px;  -->
          <div id="heatmap" class="heatmap"></div>
        </div>
       </div>
       <div class="bar-slide1">
        <div class="bar-slide1-title">
         <ul>
          <li>Booth</li>
          <li>Current Visitor Number</li>
          <li>Cumulative Visitor Number</li>
          <li>Average Visit Time(Min)</li>
         </ul>
        </div>
        <div class="bar-slide1-list" id="bar-slide1-list">
        </div>
        <div class="qr">&nbsp;</div>
       </div>
      </div>
    </div>
	<div class="swiper-slide" id="vdf">
		<div class="slide-box">
		<!--<header>SERVICE ANCHOR:<span> DIGITAL FOOTPRINT ANALYSIS SOLUTION</span></header>-->
			<header>&nbsp;</header>
			<div class="numbern-data-list" id="numbern-data-list-slide2">
				<ul>
	 				<li><span id="numbern-data-item1-slide2"></span><span class="numbern-data-item">Current Visitor Number</span></li>
					<li><span id="numbern-data-item2-slide2"></span><span class="numbern-data-item">Cumulative Visitor Number</span></li>
					<li><span id="numbern-data-item3-slide2"></span><span class="numbern-data-item">Average Visit Time(Min)</span></li>
				</ul>
			</div>
			<div class="heatmap-slide2">
				<div id="heatmap-slide2-graphic">
					<div id="heatmap2"></div>
				</div>
			</div>
			<!--  <div class="slide-box-tip">Hall 3</div>-->
			<div class="slide-box-tip slide-box-tip-slide3" style="width: 1757px;left: 44%"><span class="slide-box-tip-title-v">Hall 3</span><span class="slide-box-tip-title-h">Vodafone Exhibition Hall</span></div>
		</div>
	</div>
	<div class="swiper-slide" id="other">
		<div class="slide-box">
		<!--<header>SERVICE ANCHOR:<span> DIGITAL FOOTPRINT ANALYSIS SOLUTION</span></header>-->
			<header>&nbsp;</header>
			<div class="numbern-data-list" id="numbern-data-list-slide3">
				<ul>
					<li><span id="numbern-data-item1-slide3"></span><span class="numbern-data-item">Current Visitor Number</span></li>
					<li><span id="numbern-data-item2-slide3"></span><span class="numbern-data-item">Cumulative Visitor Number</span></li>
					<li><span id="numbern-data-item3-slide3"></span><span class="numbern-data-item">Average Visit Time(Min)</span></li>
				</ul>
			</div>
			<div class="heatmap-slide3">
				<div id="heatmap-slide3-graphic">
					<div id="heatmap3"></div>
					<!--  横屏热力图大小： width:1555px; height:590px;  -->
					<!--  竖屏热力图大小： width:517px; height:1479px;  -->
					</div>
				</div>
			<div class="slide-box-tip slide-box-tip-slide3"><span class="slide-box-tip-title-v">Hall 6</span><span class="slide-box-tip-title-h">Other Exhibition Hall</span></div>
		</div>
	</div>
</div>
  <!-- Add Pagination -->
  <div class="swiper-pagination"></div>
</div>
<script type="text/javascript">
		var configObj = {
			container : document.getElementById("heatmap"),
			maxOpacity : .6,
			radius : 20,
			blur : .90,
			backgroundColor : 'rgba(0, 0, 58, 0.1)'
		};
		var configObj2 = {
			container : document.getElementById("heatmap2"),
			maxOpacity : .6,
			radius : 20,
			blur : .90,
			backgroundColor : 'rgba(0, 0, 58, 0.1)'
		};
		var configObj3 = {
			container : document.getElementById("heatmap3"),
			maxOpacity : .6,
			radius : 20,
			blur : .90,
			backgroundColor : 'rgba(0, 0, 58, 0.1)'
		};
		var legendCanvas = document.createElement('canvas');
		legendCanvas.width = 100;
		legendCanvas.height = 10;
		var gradientImg = document.querySelector('#gradient');

		var legendCtx = legendCanvas.getContext('2d');
		var gradientCfg = {};

		var demoWrapper = document.querySelector('.demo-wrapper');
		var tooltip = document.querySelector('.tip');
		jQuery(document).ready(function() {
			// App.init();
			Heatmap.initDropdown();
		});
	</script>
</body>
</html>