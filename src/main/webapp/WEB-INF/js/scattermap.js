;(function($,win){
		
	function ScatterMap(opt)
	{
		// 默认选项
		this._opt = {
			mapUrl : "",		// 获取地图信息url
			dataUrl : "",		// 获取数据url
			floorNo : "",		// 楼层号
			domDiv : "",		// 散点图div
			parentDiv : "",		// 散点图父层div
			wrapperWidth : 700,	// 散点图限定宽度
			wrapperHeight : 500,// 散点图限定高度
			times : 10,			// 设定取多长时间内的散点图
			timeInterval : 4000,   // 散点图刷新时间
			lang:"zh-cn",			   // 语言选项
			onDataCallback : null, // 收到数据后的回调函数
			noDataCallback : null  // 没有数据情况下的回调函数
		};
		$.extend(this._opt,opt);
		
		this.lang = {
				"en":{
					name:"Name",
					tel:"Mobile Phone",
					role:"Role",
					send:"Send"
				},
				"zh-cn":{
					name:"姓名",
					tel:"电话",
					role:"角色",
					send:"发送"
				}
		}
	}
	
	ScatterMap.prototype = {
		// 验证参数是否正确
		_checkIsError : function(){
			return (!this._opt.mapUrl|| !this._opt.dataUrl || !this._opt.floorNo);
		},
		
		// 由wrapper宽高计算地图在页面上显示的宽高及缩放比
		_calImgSize : function(width, height, wrapperWidth, wrapperHeight) {
			var newWidth, newHeight, imgScale;

			// 以wrapper的高为图片新高
			if (wrapperWidth / wrapperHeight > width / height) {
				newHeight = wrapperHeight;
				imgScale = height / newHeight;
				newWidth = width / imgScale;
			} else {// 以wrapper的宽为图片新宽
				newWidth = wrapperWidth;
				imgScale = width / newWidth;
				newHeight = height / imgScale;
			}

			return [ imgScale, newWidth, newHeight ];
		},
		
		// 数据转换，由实际数据根据地图原点及比例尺，转换为图上坐标点
		//data：原始数据, xo：原点x坐标, yo：原点y坐标, scale：地图比例尺, width：地图宽, height：地图高, coordinate坐标系,imgScale：地图缩放比
		//scale：像素/实际，imgScale：原始像素/展示像素
		_dataFilter : function(data, xo, yo, scale, width, height, coordinate,imgScale) {
			var list = [];
			xo = parseFloat(xo);
			yo = parseFloat(yo);
			scale = parseFloat(scale);
			switch (coordinate){
			// 左上坐标系
			case "ul":
				for ( var i in data) {
					var point = {
						x : (data[i].x / 10 * scale + xo * scale) / imgScale+Math.random()/10,
						y : (data[i].y / 10 * scale + yo * scale) / imgScale+Math.random()/10,
						userId : data[i].userID,
						role : data[i].role,
						phone : data[i].phoneNumber,
						userName : data[i].userName
					};

					list.push(point);
				}
				break;
			// 左下坐标系
			case "ll":
				for ( var i in data) {
					var point = {
						x : (data[i].x / 10 * scale + xo * scale) / imgScale+Math.random()/10,
						y : height - (data[i].y / 10 * scale + yo * scale) / imgScale+Math.random()/10,
						userId : data[i].userID,
						role : data[i].role,
						phone : data[i].phoneNumber,
						userName : data[i].userName
					};
					list.push(point);
				}
				break;
			// 右上坐标系
			case "ur":
				for ( var i in data) {
					var point = {
						x : width - (data[i].x / 10 * scale + xo * scale) / imgScale+Math.random()/10,
						y : (data[i].y / 10 * scale + yo * scale) / imgScale+Math.random()/10,
						userId : data[i].userID,
						role : data[i].role,
						phone : data[i].phoneNumber,
						userName : data[i].userName
					};
					list.push(point);
				}
				break;
			// 右下坐标系
			case "lr":
				for ( var i in data) {
					var point = {
						x : width - (data[i].x / 10 * scale + xo * scale) / imgScale+Math.random()/10,
						y : height - (data[i].y / 10 * scale + yo * scale) / imgScale+Math.random()/10,
						userId : data[i].userID,
						role : data[i].role,
						phone : data[i].phoneNumber,
						userName : data[i].userName
					};
					list.push(point);
				}
				break;
			}

			return list;
		},
		
		// 
		_popUpMessage : function(data){
			var parentDom = this._opt.parentDiv;
			if($(parentDom + " .popDiv")){
				$(parentDom + " .popDiv").remove();
			}
			var langSet = this._opt.lang;
			var messageDiv = ''
				+'<div class="popDiv">'
				+'	<div style="margin: 40px;">'
				+'    	<div class="row-fluid">'
				+'    		<div class="span12">'
				+'    			<i id="closePop" class="icon-remove icon-large pull-right" style="margin-right:10px;cursor:pointer;" aria-hidden="true"></i>'
				+'    		</div>'
				+'    	</div>'
				+'    	<div class="row-fluid">'
				+'    		<div class="span5">'+this.lang[langSet]['name']+'</div>'
				+'    		<div class="span7">'+data.userName+'</div>'
				+'    	</div>'
				+'    	<div class="row-fluid">'
				+'    		<div class="span5">'+this.lang[langSet]['tel']+'</div>'
				+'    		<div class="span7">'+data.phone+'</div>'
				+'    	</div>'
				+'    	<div class="row-fluid">'
				+'    		<div class="span5">'+this.lang[langSet]['role']+'</div>'
				+'    		<div class="span7">'+data.role+'</div>'
				+'    	</div>'
				+'    	<div class="row-fluid">'
				+'    		<div class="span5">ID</div>'
				+'    		<div id="popUserId" class="span7">'+data.userId+'</div>'
				+'    	</div>'
				+'    	<div class="row-fluid">'
				+'    		<div class="span9"><input id="messageContent" type="text"/></div>'
				+'    		<div class="span3"><button id="sendMsg" class="btn">'+this.lang[langSet]['send']+'</button></div>'
				+'    	</div>'
				+' 	</div>'
				+'</div>';
			$(parentDom).append(messageDiv);
			$("#sendMsg").unbind("click").bind("click",function(e){
				var message = $("#messageContent").val();
				var id = $("#popUserId").text();
				if(message){
					$.post("/sva/scattermap/api/sendMessage",{message:message, userid:id},function(data){
						if(data.error){
							alert("Failed to send messsage")
						}else{
							alert("Message sent!");
							$("#messageContent").val("");
						}
					});
				}else{
					alert("Message cannot be empty");
				}
			});
			
			$("#closePop").unbind("click").bind("click",function(e){
				$(parentDom + " .popDiv").remove();
			});
		},
		
		// svg初始化
		_initSvg : function(data){
			var _this = this;
			//点的初始化
			this.svg = d3.select(this._opt.domDiv)     		//选择文档中的body元素
				.append("svg")          			//添加一个svg元素
				.attr("width", this.imgWidth)       //设定宽度
				.attr("height", this.imgHeight);    //设定高度
			
			this.svg.selectAll("circle")
				.data(data)
				.enter()
				.append("circle")
				.attr("class",function(d,i){
					if(d.role == "2"){
						return "pointGuard";
					}else if(d.role == "1"){
						return "pointVip";
					}else{
						return "pointCommon";
					}
				})
				.attr("cx", function(d,i){return d.x;})
				.attr("cy", function(d,i){return d.y;})
				.attr("r", 5);	
			
			// 冒泡的初始化	
			var dataPump = _.filter(data, function(d){ return d.role == "2"; });
			this.svg.selectAll("path")
				.data(dataPump)
				.enter()
				.append("path")
				.attr("d",function(d){
					var path = "M"+ (d.x-20)+" "+(d.y-20)+" "+"A28 28,0,1,1 "+(d.x+20)+" "+(d.y-20)+" L"+d.x+" "+d.y+" Z";
					return path;
				})
				.attr("fill","rgba(202,58,58,0.9)")
				.attr("style","cursor:pointer")
				.on("click",function(d){
					_this._popUpMessage(d);
		        });
			
			// 特殊角色姓名初始化
			this.svg.selectAll(".MyText")
		        .data(dataPump)
		        .enter()
		        .append("text")
		        .attr("class","MyText")
		        .attr("x", function(d){
		            return d.x-18;
		        } )
		        .attr("y",function(d){
		            return d.y-40;
		        })
		        .attr("dx",function(){
		            return 20;
		        })
		        .attr("dy",function(d){
		            return 6;
		        })
		        .attr("text-anchor","middle")
		        .attr("style","cursor:pointer")
				.on("click",function(d){
					_this._popUpMessage(d);
		        })
		        .text(function(d){
		            return d.userName;
		        });
			
		},
		
		// svg更新
		_updateSvg : function(data){
			var _this = this;
			//------点的更新start------
			var update = this.svg.selectAll("circle")
				.data(data,function(d){return d.userId;});
			var enter = update.enter(),
				exit = update.exit();
			// 渐变时间基于散点图刷新时间+1
			var timeInterval = this._opt.timeInterval+1000;
			
			// 更新的改变坐标
			update.transition()
				.duration(timeInterval)
				.ease("liner")
				.attr("class",function(d,i){
					if(d.role == "2"){
						return "pointGuard";
					}else if(d.role == "1"){
						return "pointVip";
					}else{
						return "pointCommon";
					}
				})
				.attr("cx", function(d,i){return d.x;})
				.attr("cy", function(d,i){return d.y;});
			
			// 新增的添加
			enter.append("circle")
				.attr("class",function(d,i){
					if(d.role == "2"){
						return "pointGuard";
					}else if(d.role == "1"){
						return "pointVip";
					}else{
						return "pointCommon";
					}
				})
				.attr("cx", function(d,i){return d.x;})
				.attr("cy", function(d,i){return d.y;})
				.attr("r", 5);
				
			// 消失的删除
			exit.remove();
			//------点的更新end------
			
			//------冒泡的更新start------
			var dataPump = _.filter(data, function(d){ return d.role == "2"; });
			var updatePump = this.svg.selectAll("path")
				.data(dataPump,function(d){return d.userId;});
			var enterPump = updatePump.enter(),
				exitPump = updatePump.exit();
			
			// 更新的改变坐标
			updatePump.transition()
				.duration(timeInterval)
				.ease("liner")
				.attr("d",function(d){
					var path = "M"+ (d.x-20)+" "+(d.y-20)+" "+"A28 28,0,1,1 "+(d.x+20)+" "+(d.y-20)+" L"+d.x+" "+d.y+" Z";
					return path;
				});
			
			// 新增的添加
			enterPump.append("path")
				.attr("d",function(d){
					var path = "M"+ (d.x-20)+" "+(d.y-20)+" "+"A28 28,0,1,1 "+(d.x+20)+" "+(d.y-20)+" L"+d.x+" "+d.y+" Z";
					return path;
				})
				.attr("fill","rgba(202,58,58,0.9)")
				.attr("style","cursor:pointer")
				.on("click",function(d){
					_this._popUpMessage(d);
		        });
				
			// 消失的删除
			exitPump.remove();			
			//------冒泡的更新end------
			
			//------text的更新start------
			var updateText = this.svg.selectAll(".MyText")
				.data(dataPump,function(d){return d.userId;});
			var enterText = updateText.enter(),
				exitText = updateText.exit();
			
			// 更新的改变坐标
			updateText.transition()
				.duration(timeInterval)
				.ease("liner")
		        .attr("x", function(d){
		            return d.x-18;
		        } )
		        .attr("y",function(d){
		            return d.y-40;
		        })
		        .text(function(d){
		            return d.userName;
		        });
			
			// 新增的添加
			enterText.append("text")
				.attr("class","MyText")
		        .attr("x", function(d){
		            return d.x-18;
		        } )
		        .attr("y",function(d){
		            return d.y-40;
		        })
		        .attr("dx",function(){
		            return 20;
		        })
		        .attr("dy",function(d){
		            return 6;
		        })
		        .attr("text-anchor","middle")		        
		        .attr("style","cursor:pointer")
				.on("click",function(d){
					_this._popUpMessage(d);
		        })
		        .text(function(d){
		            return d.userName;
		        });
				
			// 消失的删除
			exitText.remove();			
			//------text的更新end------
		},
		
		// 初始化散点图
		_initScattermap : function() {
			var _this = this;
			// 检查选项参数是否有误
			if(_this._checkIsError()) return;
			// 先清空之前的热力图
			_this._removeScatter();
			// 获取地图信息
			$.post(_this._opt.mapUrl, {
				floorNo : _this._opt.floorNo
			}, function(data) {
				if (!data.error) {
					if (data.bg) {
						// 全局变量赋值
						_this.origX = data.xo;
						_this.origY = data.yo;
						_this.bgImg = data.bg;
						_this.bgImgWidth = data.bgWidth;
						_this.bgImgHeight = data.bgHeight;
						_this.scale = data.scale;
						_this.coordinate = data.coordinate;
						// 设置背景图片
						var bgImgStr = "url(../upload/" + _this.bgImg + ")";
						var imgInfo = _this._calImgSize(_this.bgImgWidth, _this.bgImgHeight, _this._opt.wrapperWidth, _this._opt.wrapperHeight);
						_this.imgScale = imgInfo[0];
						_this.imgWidth = imgInfo[1];
						_this.imgHeight = imgInfo[2];
						
						$(_this._opt.domDiv).css({
							"width" : _this.imgWidth + "px",
							"height" : _this.imgHeight + "px",
							"background-image" : bgImgStr,
							"background-size" : _this.imgWidth + "px " + _this.imgHeight + "px",
							"margin" : "0 auto"
						});
						
						// 添加数据
						$.post(_this._opt.dataUrl, {
							floorNo : _this._opt.floorNo,times:_this._opt.times
						}, function(data) {
							if (!data.error) {
								if (data.data && data.data.length > 0) {
									// var points = {max:1,data:dataFilter(data)};
									var points = _this._dataFilter(data.data, _this.origX,
											_this.origY, _this.scale, _this.imgWidth, _this.imgHeight,
											_this.coordinate, _this.imgScale);

									
									_this._initSvg(points);
									
									// 执行回调函数
									if(_this._opt.onDataCallback){
										_this._opt.onDataCallback(data);
									}
								}
							}
						});
						
						// 定时刷新
						if(_this.timer){
							clearTimeout(_this.timer);
						}
						_this.timer = setTimeout(function(){_this._refreshScattermapData()}, _this._opt.timeInterval);
					}
				}
			});
		},
		
		// 散点图数据刷新
		_refreshScattermapData : function() {
			var _this = this;
			$.post(_this._opt.dataUrl, {floorNo : _this._opt.floorNo,times:_this._opt.times}, function(data) {
				if (!data.error) {
					if (data.data && data.data.length > 0) {
						// var points = {max:1,data:dataFilter(data)};
						var points = _this._dataFilter(data.data, _this.origX, _this.origY, _this.scale,
								_this.imgWidth, _this.imgHeight, _this.coordinate, _this.imgScale);

						_this._updateSvg(points);
						if(_this._opt.onDataCallback){
							_this._opt.onDataCallback(data);
						}
					}else{
						if(_this._opt.noDataCallback){
							_this._opt.noDataCallback(data);
						}
					}
				}
				// 定时刷新
				if(_this.timer){
					clearTimeout(_this.timer);
				}
				this.timer = setTimeout(function(){_this._refreshScattermapData()}, _this._opt.timeInterval);
			});
		},
		
		// 清除散点图
		_removeScatter : function(){
			$(this._opt.domDiv).empty();
		},
		
		// 改变散点图设置
		_changeOption : function(opt){
			$.extend(this._opt,opt);
		}
		
	};
	
	var scatterMapCreator = {
		scatterInstance : null,
		create : function(opt){
			if(this.scatterInstance){
				var sm = this.scatterInstance;
				sm._changeOption(opt);
				sm._initScattermap();
				return sm;
			}else{
				var sm = new ScatterMap(opt);
				sm._initScattermap();
				this.scatterInstance = sm;
				return sm;				
			}
		}
	};
	win["scatterMapCreator"] = scatterMapCreator;
})(jQuery,window);

var ScattermapPage = function() {

	/**
	 * 将对应信息填充到对应的select @ param renderId [string] 标签id @ param data [array]
	 *                   列表数据
	 */
	var updateList = function(renderId, data, selectTxt, callback) {
		var sortData = data.sort(function(a, b) {
			return a.name - b.name;
		});
		var len = sortData.length;
		var options = '';
		for ( var i = 0; i < len; i++) {
			if(sortData[i].id == selectTxt){
				options += '<option class="addoption" selected value="'
					+ sortData[i].id + '">' + HtmlDecode3(sortData[i].name)
					+ '</option>';
			}else{
				options += '<option class="addoption" value="'
					+ sortData[i].id + '">' +HtmlDecode3(sortData[i].name)
					+ '</option>';
			}
		}
		removeOption(renderId);
		$('#' + renderId).append(options);
		if (callback) {
			callback();
		}
		return;
	};

	/**
	 * 将对应信息填充到对应的select @ param renderId [string] 标签id @ param data [array]
	 *                   列表数据
	 */
	var updateFloorList = function(renderId, data, selectTxt, callback) {
		var sortData = data.sort(function(a, b) {
			return a.floor - b.floor;
		});
		var len = sortData.length;
		var options = '';
		for ( var i = 0; i < len; i++) {
			if(sortData[i].floorNo == selectTxt){
				options += '<option class="addoption" selected value="'
					+ sortData[i].floorNo + '">' + sortData[i].floor
					+ '</option>';
			}else{
				options += '<option class="addoption" value="'
					+ sortData[i].floorNo + '">' + sortData[i].floor
					+ '</option>';
			}
		}
		removeOption(renderId);
		$('#' + renderId).append(options);
		if (callback) {
			callback();
		}
		return;
	};

	var removeOption = function(renderId) {
		$('#' + renderId + ' .addoption').remove().trigger("liszt:updated");
	};

	
	var changeFloor = function(placeId, floorNo, callback){
		$.post("/sva/heatmap/api/getFloorsByMarket", {
			placeId : placeId
		}, function(data) {
			if (!data.error) {
				var floors = data.data;
				updateFloorList("floorSel", floors, floorNo, function() {
					$('#floorSel').trigger("liszt:updated");
					callback();
				});
			}
		});
	};
	
	var initScattermap = function(opt){
		scatterMapCreator.create(opt);
	};
	
	return {
		// 初始化下拉列表
		initDropdown : function() {
			$("#marketSel").chosen();
			$("#floorSel").chosen();
			$("#densitySel").chosen({
				width : 80
			});
			$("#radiusSel").chosen({
				width : 80
			});
		
			var placeId = $.cookie("place");
			var floorNo = $.cookie("floor");
			var t = $.cookie("times");
			if (t==undefined) {
				var times = $("#time").val();
				t = times;
				$.cookie("times", times, { expires: 30});
			}
			
			//var place = $("#marketSel").val();
			var array=new Array();
			var arrayfloor=new Array();
			$.get("/sva/store/api/getData?t="+Math.random(), function(data) {
				if (!data.error) {
					var storeList = data.data;
					updateList("marketSel", storeList,placeId, function() {
						$('#marketSel').trigger("liszt:updated");
						$("#marketSel option").each(function(){ //遍历全部option 
							//	var txt = $(this).text(); //获取单个text
							var val = $(this).val(); //获取单个value
							var node =val;
							array.push(node);
							
						}); 						
						
						for(var i= 0;i<array.length;i++){
							if(array[i] == placeId){
								changeFloor(placeId,floorNo,function(){
									$("#floorSel option").each(function(){ //遍历全部option 
										//	var txt = $(this).text(); //获取单个text
										var val = $(this).val(); //获取单个value
										var node =val;
										arrayfloor.push(node);
										
									}); 
									for(var i= 0;i<arrayfloor.length;i++){
										if(arrayfloor[i] == floorNo){
											 $("#time").val(t);
											$('#confirm').click();
										}
										
									}
								});							
							}
						}
					});
				}
			});
		},

		bindClickEvent : function() {
			// 地点下拉列表修改 触发楼层下拉列表变化
			$("#marketSel").chosen().change(function() {
				var placeId = $("#marketSel").val();
				changeFloor(placeId);
			});
			
			// 确认按钮点击 触发热力图刷新
			$('#confirm').click(function(e) {
				var placeId = $("#marketSel").val();
				var floorNo = $("select[name='floorSelName']").find("option:selected").val();
			    var floor = $("select[name='floorSelName']").find("option:selected").text();
			   
			    if (placeId=="") {
			    	$("#marketSel").blur();
			    	return false;
				}
			    if (floorNo=="") {
			    	$("#floorSel").blur();
			    	return false;
				}
			    $("#floorSel").blur();
				$("#mainContent").show();
				// 散点图选项设置
				var opt = {
						mapUrl : "/sva/heatmap/api/getMapInfoByPosition",
						dataUrl : "/sva/scattermap/api/getData?t="+Math.random(),
						floorNo : floorNo,
						domDiv : "#scattermap",
						parentDiv : "#mapContainer",	
						wrapperWidth : parseInt($("#divCon").css("width").slice(0, -2)),
						wrapperHeight : 600,
						lang:lang_info
					};
				initScattermap(opt);
				$.cookie("place", placeId, { expires: 30});
				$.cookie("floor", floorNo, { expires: 30});

			});
		}

	};

}();