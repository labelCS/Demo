;(function($,win){
		
	function AdvancedHeatMap(opt, heatMapOpt)
	{
		// 默认选项
		this._opt = {
			mapUrl : "",		// 获取地图信息url
			dataUrl : "",		// 获取数据url
			floorNo : "",		// 楼层号
			domDiv : "",		// 热力图div
			parentDiv : "",		// 热力图父层div
			wrapperWidth : 700,	// 热力图限定宽度
			wrapperHeight : 500,// 热力图限定高度
			times : 10,			// 设定取多长时间内的热力图
			timeInterval : 4,	// 热力图刷新时间
			pointVal : 5,		// 密度
			legend : false,		// 是否有图例
			updateLegend : null,// 图例更新事件
			onDataCallback : null, // 收到数据后的回调函数
			noDataCallback : null  // 没有数据情况下的回调函数
		};
		$.extend(this._opt,opt);
		
		// 热力图选项
		this._heatmapOpt = heatMapOpt;
		// 热力图实例
		this._heatmapInstance = null;
	}
	
	AdvancedHeatMap.prototype = {
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
						value : 1
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
						value : 1
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
						value : 1
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
						value : 1
					};
					list.push(point);
				}
				break;
			}

			return list;
		},
		
		// 清空热力图
		_removeHeatmap : function(){
			$(this._opt.parentDiv).css("background-image", "");
			$(this._opt.domDiv).empty();
		},
		
		// 初始化热力图
		_initHeatmap : function() {
			var _this = this;
			// 检查选项参数是否有误
			if(_this._checkIsError()) return;
			// 先清空之前的热力图
			_this._removeHeatmap();
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
						
						$(_this._opt.parentDiv).css({
							"width" : _this.imgWidth + "px",
							"height" : _this.imgHeight + "px",
							"background-image" : bgImgStr,
							"background-size" : _this.imgWidth + "px " + _this.imgHeight + "px",
							"margin" : "0 auto"
						});

						// 更新图例事件
						if(_this._opt.legend){
							_this._heatmapOpt.onExtremaChange = function(data) {
								var updateFunc = _this._opt.updateLegend;
								updateFunc(data);
							};							
						}
						
						// 热力图实例化
						_this._heatmapInstance = h337.create(_this._heatmapOpt);
						
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
									var dataObj = {
										max : _this._opt.pointVal,
										min : 1,
										data : points
									};
									_this._heatmapInstance.setData(dataObj);
									
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
						_this.timer = setTimeout(function(){_this._refreshHeatmapData()}, _this._opt.timeInterval);
					}
				}
			});
		},
		
		// 热力图数据刷新
		_refreshHeatmapData : function() {
			var _this = this;
			$.post(_this._opt.dataUrl, {floorNo : _this._opt.floorNo,times:_this._opt.times}, function(data) {
				if (!data.error) {
					if (data.data && data.data.length > 0) {
						// var points = {max:1,data:dataFilter(data)};
						var points = _this._dataFilter(data.data, _this.origX, _this.origY, _this.scale,
								_this.imgWidth, _this.imgHeight, _this.coordinate, _this.imgScale);
						var dataObj = {
							max : _this._opt.pointVal,
							min : 1,
							data : points
						};
						_this._heatmapInstance.setData(dataObj);
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
				this.timer = setTimeout(function(){_this._refreshHeatmapData()}, _this._opt.timeInterval);
			});
		},
		
		// 改变热力图选项
		_changeHeatmapOption : function(opt){
			$.extend(this._heatmapOpt,opt);
		},
		
		// 改变AdvancedHeatMap选项
		_changeAHMOption : function(opt){
			$.extend(this._opt,opt);
		}
		
	};
	
	var heatMapCs = {
		create : function(opt, heatMapOpt){
			var hm = new AdvancedHeatMap(opt, heatMapOpt);
			//hm._initHeatmap();
			return hm;
		}
	};
	win["heatMapCs"] = heatMapCs;
})(jQuery,window);