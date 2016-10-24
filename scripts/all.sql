-- --------------------------------------------------------
-- 主机:                           localhost
-- 服务器版本:                        5.5.40 - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win32
-- HeidiSQL 版本:                  8.3.0.4833
-- --------------------------------------------------------
-- 导出  表 sva.store 结构
CREATE TABLE IF NOT EXISTS `store` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 导出  表 sva.maps 结构
CREATE TABLE IF NOT EXISTS `maps` (
	`floor` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`xo` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`yo` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`scale` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`coordinate` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`angle` FLOAT NOT NULL DEFAULT '0',
	`path` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`placeId` INT(11) NULL DEFAULT NULL,
	`mapId` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	`floorNo` DECIMAL(10,2) NULL DEFAULT NULL,
	`imgWidth` INT(11) NULL DEFAULT NULL,
	`imgHeight` INT(11) NULL DEFAULT NULL,
	`floorid` DECIMAL(10,2) NULL DEFAULT NULL,
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`svg` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	`route` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	`pathfile` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	`updateTime` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	`zAnMap` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	`zIosMap` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	`zAnMapPath` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	`zIosMapPath` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	PRIMARY KEY (`id`),
	UNIQUE INDEX `floorNo` (`floorNo`),
	INDEX `FK_maps_store` (`placeId`),
	CONSTRAINT `FK_maps_store` FOREIGN KEY (`placeId`) REFERENCES `store` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
)
COMMENT='地图信息'
COLLATE='utf8_unicode_ci'
ENGINE=InnoDB
AUTO_INCREMENT=20;


CREATE TABLE IF NOT EXISTS `category` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `updateTime` datetime DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 导出  表 sva.role 结构
CREATE TABLE IF NOT EXISTS `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `menukey` varchar(2000) DEFAULT NULL,
  `menus` varchar(255) DEFAULT NULL,
  `storesid` varchar(255) DEFAULT NULL,
  `stores` varchar(255) DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index 2` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
INSERT INTO `role` (`id`, `name`, `menukey`, `menus`, `storesid`, `stores`, `updateTime`) VALUES
	(1, '1', '1', '1', '1', '1', '2016-06-25 05:28:33');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
-- 导出  表 sva.account 结构
CREATE TABLE IF NOT EXISTS `account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleid` int(11) NOT NULL,
  `username` varchar(50) COLLATE utf8_bin NOT NULL,
  `password` varchar(50) COLLATE utf8_bin NOT NULL,
  `updateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index 3` (`username`),
  KEY `fk_account_role` (`roleid`) USING BTREE,
  CONSTRAINT `fk_roleid` FOREIGN KEY (`roleid`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  sva.account 的数据：~1 rows (大约)
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` (`id`, `roleid`, `username`, `password`, `updateTime`) VALUES
	(1, 1, 'admin', 'admin', '2016-06-25 05:28:55');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;


-- 导出  表 sva.accuracy 结构
CREATE TABLE IF NOT EXISTS `accuracy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `placeId` int(11) NOT NULL,
  `floorNo` decimal(10,2) NOT NULL,
  `origin` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `destination` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `type` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `triggerIp` varchar(50) CHARACTER SET utf8 NOT NULL,
  `offset` decimal(10,2) NOT NULL,
  `variance` decimal(10,2) NOT NULL,
  `averDevi` decimal(10,2) NOT NULL,
  `count_3` int(11) NOT NULL,
  `count_5` int(11) NOT NULL,
  `count_10` int(11) NOT NULL,
  `count_10p` int(11) NOT NULL,
  `detail` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 正在导出表  sva.accuracy 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `accuracy` DISABLE KEYS */;
/*!40000 ALTER TABLE `accuracy` ENABLE KEYS */;


-- 导出  表 sva.allpeople 结构
CREATE TABLE IF NOT EXISTS `allpeople` (
  `time` varchar(50) NOT NULL,
  `nowNumber` int(11) NOT NULL,
  `yesterNumber` int(11) NOT NULL,
  `placeId` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  PRIMARY KEY (`time`,`placeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='每分钟更新今日人数和昨日人数';

-- 正在导出表  sva.allpeople 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `allpeople` DISABLE KEYS */;
/*!40000 ALTER TABLE `allpeople` ENABLE KEYS */;


CREATE TABLE IF NOT EXISTS `area` (
	`areaName` VARCHAR(255) NOT NULL,
	`placeId` INT(11) NOT NULL,
	`id` INT(10) NOT NULL AUTO_INCREMENT,
	`floorNo` DECIMAL(10,2) NOT NULL,
	`xSpot` DECIMAL(10,2) NOT NULL,
	`ySpot` DECIMAL(10,2) NOT NULL,
	`status` INT(11) NOT NULL DEFAULT '0',
	`zoneId` VARCHAR(50) NULL DEFAULT NULL,
	`x1Spot` DECIMAL(10,2) NOT NULL,
	`y1Spot` DECIMAL(10,2) NOT NULL,
	`categoryid` INT(10) NOT NULL,
	`ISVIP` VARCHAR(50) NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `FK_message_maps` (`placeId`) USING BTREE,
	INDEX `FK_message_store` (`floorNo`) USING BTREE,
	INDEX `FK_message_category` (`categoryid`) USING BTREE,
	CONSTRAINT `area_ibfk_1` FOREIGN KEY (`placeId`) REFERENCES `store` (`id`) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT `area_ibfk_2` FOREIGN KEY (`floorNo`) REFERENCES `maps` (`floorNo`) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT `area_ibfk_3` FOREIGN KEY (`categoryid`) REFERENCES `category` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB;


-- 正在导出表  sva.area 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `area` DISABLE KEYS */;
/*!40000 ALTER TABLE `area` ENABLE KEYS */;


-- 导出  表 sva.bluemix 结构
CREATE TABLE IF NOT EXISTS `bluemix` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `svaUser` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `svaPassword` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `site` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ibmUser` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ibmPassword` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `tokenPort` int(11) NOT NULL,
  `brokerPort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 正在导出表  sva.bluemix 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `bluemix` DISABLE KEYS */;
/*!40000 ALTER TABLE `bluemix` ENABLE KEYS */;


-- 导出  表 sva.bzprames 结构
CREATE TABLE IF NOT EXISTS `bzprames` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `placeId` int(11) NOT NULL,
  `placeId2` int(11) NOT NULL,
  `placeId2sp` int(11) NOT NULL,
  `placeId3` int(11) NOT NULL,
  `placeId3sp` int(11) NOT NULL,
  `floorNo` decimal(10,2) NOT NULL,
  `floorNo2` decimal(10,2) NOT NULL,
  `floorNo2sp` decimal(10,2) NOT NULL,
  `floorNo3` decimal(10,2) NOT NULL,
  `floorNo3sp` decimal(10,2) NOT NULL,
  `periodSel` int(10) NOT NULL,
  `startTime` datetime NOT NULL,
  `densitySel` int(11) DEFAULT NULL,
  `radiusSel` int(11) DEFAULT NULL,
  `densitySel1` int(11) DEFAULT NULL,
  `densitySel2` int(11) DEFAULT NULL,
  `radiusSel1` int(11) DEFAULT NULL,
  `radiusSel2` int(11) DEFAULT NULL,
  `coefficient` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fgffgf` (`placeId`) USING BTREE,
  KEY `dfdf` (`floorNo`) USING BTREE,
  KEY `fk_floorId2` (`floorNo2`),
  KEY `fk_floorId3` (`floorNo3`),
  KEY `fk_place2` (`placeId2`) USING BTREE,
  KEY `fk_floorId2sp` (`floorNo2sp`),
  KEY `fk_floorId3sp` (`floorNo3sp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  sva.bzprames 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `bzprames` DISABLE KEYS */;
/*!40000 ALTER TABLE `bzprames` ENABLE KEYS */;



-- 导出  表 sva.code 结构
CREATE TABLE IF NOT EXISTS `code` (
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 正在导出表  sva.code 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `code` DISABLE KEYS */;
INSERT INTO `code` (`name`, `password`) VALUES
	('admin', 'admin');
/*!40000 ALTER TABLE `code` ENABLE KEYS */;


-- 导出  表 sva.district_during 结构
CREATE TABLE IF NOT EXISTS `district_during` (
  `idType` varchar(50) DEFAULT NULL,
  `timestamp` bigint(20) DEFAULT NULL,
  `time_begin` bigint(20) DEFAULT NULL,
  `time_local` bigint(20) DEFAULT NULL,
  `during` bigint(20) DEFAULT NULL,
  `dataType` varchar(50) DEFAULT NULL,
  `district_id` int(11) NOT NULL,
  `userID` varchar(50) NOT NULL,
  `loc_count` bigint(20) DEFAULT NULL,
  `departure_time` bigint(20) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 正在导出表  sva.district_during 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `district_during` DISABLE KEYS */;
/*!40000 ALTER TABLE `district_during` ENABLE KEYS */;


-- 导出  表 sva.dynamicaccuracy 结构
CREATE TABLE IF NOT EXISTS `dynamicaccuracy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `placeId` int(11) NOT NULL,
  `floorNo` decimal(10,2) NOT NULL,
  `origin` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `destination` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `avgeOffset` decimal(10,2) NOT NULL,
  `maxOffset` decimal(10,2) NOT NULL,
  `Offset` decimal(10,2) NOT NULL,
  `count_3` int(11) NOT NULL,
  `count_5` int(11) NOT NULL,
  `count_10` int(11) NOT NULL,
  `count_10p` int(11) NOT NULL,
  `detail` text COLLATE utf8_unicode_ci,
  `triggerIp` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 正在导出表  sva.dynamicaccuracy 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `dynamicaccuracy` DISABLE KEYS */;
/*!40000 ALTER TABLE `dynamicaccuracy` ENABLE KEYS */;


-- 导出  表 sva.electronic 结构
CREATE TABLE IF NOT EXISTS `electronic` (
  `placeId` int(11) NOT NULL,
  `electronicName` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `message` mediumtext CHARACTER SET utf8,
  `shopId` int(11) DEFAULT NULL,
  `pictruePath` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `moviePath` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `floorNo` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_electronic_store` (`placeId`),
  KEY `FK_electronic_maps` (`floorNo`),
  KEY `FK_electronic_area` (`shopId`),
  CONSTRAINT `FK_electronic_area` FOREIGN KEY (`shopId`) REFERENCES `area` (`id`),
  CONSTRAINT `FK_electronic_maps` FOREIGN KEY (`floorNo`) REFERENCES `maps` (`floorNo`),
  CONSTRAINT `FK_electronic_store` FOREIGN KEY (`placeId`) REFERENCES `store` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 正在导出表  sva.electronic 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `electronic` DISABLE KEYS */;
/*!40000 ALTER TABLE `electronic` ENABLE KEYS */;


-- 导出  表 sva.estimatedev 结构
CREATE TABLE IF NOT EXISTS `estimatedev` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `placeId` int(11) DEFAULT NULL,
  `floorNo` decimal(10,2) DEFAULT NULL,
  `a` decimal(10,2) DEFAULT NULL,
  `b` decimal(10,2) DEFAULT NULL,
  `n` int(11) DEFAULT NULL,
  `type` decimal(10,3) DEFAULT NULL,
  `d` decimal(10,1) DEFAULT NULL,
  `deviation` decimal(10,1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `FK_estimatedev_store` (`placeId`),
  KEY `FK_estimatedev_maps` (`floorNo`),
  CONSTRAINT `FK_estimatedev_maps` FOREIGN KEY (`floorNo`) REFERENCES `maps` (`floorNo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_estimatedev_store` FOREIGN KEY (`placeId`) REFERENCES `store` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='预估偏差';

-- 正在导出表  sva.estimatedev 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `estimatedev` DISABLE KEYS */;
/*!40000 ALTER TABLE `estimatedev` ENABLE KEYS */;


-- 导出  表 sva.geofencing 结构
CREATE TABLE IF NOT EXISTS `geofencing` (
  `IdType` varchar(50) NOT NULL,
  `time_local` varchar(50) DEFAULT NULL,
  `userid` varchar(50) NOT NULL,
  `mapid` bigint(20) NOT NULL,
  `zoneid` bigint(20) NOT NULL,
  `enter` varchar(50) NOT NULL,
  `Timestamp` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 正在导出表  sva.geofencing 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `geofencing` DISABLE KEYS */;
/*!40000 ALTER TABLE `geofencing` ENABLE KEYS */;


-- 导出  表 sva.locationdelay 结构
CREATE TABLE IF NOT EXISTS `locationdelay` (
  `id` int(11) NOT NULL DEFAULT '0',
  `placeId` int(11) DEFAULT NULL,
  `floorNo` decimal(10,2) DEFAULT NULL,
  `dataDelay` double DEFAULT NULL,
  `positionDelay` double DEFAULT NULL,
  `updateTime` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 正在导出表  sva.locationdelay 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `locationdelay` DISABLE KEYS */;
/*!40000 ALTER TABLE `locationdelay` ENABLE KEYS */;


-- 导出  表 sva.locationphone 结构
CREATE TABLE IF NOT EXISTS `locationphone` (
  `idType` varchar(50) DEFAULT NULL,
  `timestamp` bigint(20) DEFAULT NULL,
  `time_begin` bigint(20) DEFAULT NULL,
  `time_local` bigint(20) DEFAULT NULL,
  `during` bigint(20) NOT NULL DEFAULT '0',
  `dataType` varchar(50) DEFAULT NULL,
  `x` decimal(10,0) DEFAULT NULL,
  `y` decimal(10,0) DEFAULT NULL,
  `z` decimal(10,0) DEFAULT NULL,
  `userID` varchar(50) NOT NULL,
  `loc_count` bigint(20) NOT NULL DEFAULT '1',
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 正在导出表  sva.locationphone 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `locationphone` DISABLE KEYS */;
/*!40000 ALTER TABLE `locationphone` ENABLE KEYS */;


-- 导出  表 sva.locationtemp 结构
CREATE TABLE IF NOT EXISTS `locationtemp` (
  `idType` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `timestamp` bigint(20) DEFAULT NULL,
  `dataType` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `x` decimal(10,0) DEFAULT NULL,
  `y` decimal(10,0) DEFAULT NULL,
  `z` decimal(10,0) DEFAULT NULL,
  `userID` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  KEY `Index 1` (`userID`),
  KEY `Index 2` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



-- 导出  表 sva.menu 结构
CREATE TABLE IF NOT EXISTS `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '0',
  `url` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '0',
  `parent` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '0',
  `type` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '0',
  `sort` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  sva.menu 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;


-- 导出  表 sva.menuenglish 结构
CREATE TABLE IF NOT EXISTS `menuenglish` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `keyEN` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  sva.menuenglish 的数据：~28 rows (大约)
/*!40000 ALTER TABLE `menuenglish` DISABLE KEYS */;
INSERT INTO `menuenglish` (`id`, `keyEN`, `name`) VALUES
	(1, 'key_storeManage', 'Store Management'),
	(2, 'key_svaManage', 'SVA Management'),
	(3, 'key_mapManage', 'Map Management'),
	(4, 'key_messagePush', 'Message Management'),
	(5, 'key_sellerInfo', 'Seller Management'),
	(6, 'key_areaCategory', ' Regional category management '),
	(7, 'key_areaInfo', 'Regional information input'),
	(8, 'key_customerHeamap', 'Customer Heatmap'),
	(9, 'key_customerPeriodHeamap', 'Customer Heatmap in Period'),
	(10,'key_customerScattermap', 'Customer Scattermap'),
	(11,'key_historicalTrack', 'Historical Track'),
	(12,'key_CustomerFlowLinemap', 'Customer Flow Range Linemap'),
	(13,'key_code', 'Code Management'),
	(14,'key_estimateDeviation', 'Set Estimate Deviation'),
	(15,'key_summaryDisplay', 'Summary Display'),
	(16,'key_bluemixConnection', 'Bluemix Connection'),
	(17,'key_ping', 'ping'),
	(18,'key_pRRUConfig', 'pRRU Config'),
	(19, 'key_versionDownload', 'Version Downloads'),
	(20, 'key_APKDownload', 'APKDownload'),
	(21, 'key_role', 'Role management'),
	(22, 'key_paramConfig', 'Parameter configuration '),
	(23, 'key_account', 'Rights management'),
	(24, 'key_allShow', 'Global overview'),
	(25, 'key_dynamicAccuyacy', 'Dynamic accuracy test'),
	(26, 'key_staticAccuyacy', 'Static accuracy test'),
	(27, 'key_positionlatency', ' Position latency'),
	(28, 'key_MessagePush', 'Message push accuracy'),
	(29, 'key_positionMap', 'Position Distribution Map');
/*!40000 ALTER TABLE `menuenglish` ENABLE KEYS */;


-- 导出  表 sva.menuname 结构
CREATE TABLE IF NOT EXISTS `menuname` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `keyZH` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  sva.menuname 的数据：~28 rows (大约)
/*!40000 ALTER TABLE `menuname` DISABLE KEYS */;
INSERT INTO `menuname` (`id`, `keyZH`, `name`) VALUES
	(1, 'key_storeManage', '商场管理'),
	(2, 'key_svaManage', 'SVA管理'),
	(3, 'key_mapManage', '地图管理'),
	(4, 'key_messagePush', '消息推送管理'),
	(5, 'key_sellerInfo', '商户信息管理'),
	(6, 'key_areaCategory', '区域类别管理'),
	(7, 'key_areaInfo', '区域信息录入'),
	(8, 'key_customerHeamap', '客流实时热力图'),
	(9, 'key_customerPeriodHeamap', '时间段客流热力图'),
	(10, 'key_customerScattermap', '客流实时散点图'),
	(11, 'key_historicalTrack', '历史轨迹'),
	(12, 'key_CustomerFlowLinemap', '历史客流分析图'),
	(13, 'key_code', '口令管理'),
	(14, 'key_estimateDeviation', '预估偏差设定'),
	(15, 'key_summaryDisplay', '汇总结果'),
	(16, 'key_bluemixConnection', 'bluemix对接'),
	(17, 'key_ping', 'ping'),
	(18, 'key_pRRUConfig', 'pRRU配置'),
	(19, 'key_versionDownload', '版本下载'),
	(20, 'key_APKDownload', 'APK下载'),
	(21, 'key_role', '角色管理'),
	(22, 'key_account', '权限管理'),
	(23, 'key_paramConfig', '参数配置'),
	(24, 'key_allShow', '全局概览'),
	(25, 'key_dynamicAccuyacy', '动态精度测试'),
	(26, 'key_staticAccuyacy', '静态精度测试'),
	(27, 'key_positionlatency', '定位延时'),
	(28, 'key_MessagePush', '消息推送准确率'),
	(29, 'key_positionMap', '手机号归属地分布图');
/*!40000 ALTER TABLE `menuname` ENABLE KEYS */;


-- 导出  表 sva.message 结构
CREATE TABLE IF NOT EXISTS `message` (
  `placeId` int(11) NOT NULL,
  `shopName` varchar(100) CHARACTER SET utf8 NOT NULL,
  `xSpot` decimal(10,2) NOT NULL,
  `ySpot` decimal(10,2) NOT NULL,
  `rangeSpot` decimal(10,2) DEFAULT NULL,
  `timeInterval` int(10) DEFAULT NULL,
  `message` mediumtext CHARACTER SET utf8,
  `isEnable` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `pictruePath` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `moviePath` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `floorNo` decimal(10,2) DEFAULT NULL,
  `x1Spot` decimal(10,2) DEFAULT NULL,
  `y1Spot` decimal(10,2) DEFAULT NULL,
  `shopId` int(11) DEFAULT NULL,
  `ticketPath` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'null',
  PRIMARY KEY (`id`),
  KEY `FK_message_maps` (`floorNo`),
  KEY `FK_message_store` (`placeId`),
  CONSTRAINT `FK_message_maps` FOREIGN KEY (`floorNo`) REFERENCES `maps` (`floorNo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_message_store` FOREIGN KEY (`placeId`) REFERENCES `store` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 正在导出表  sva.message 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
/*!40000 ALTER TABLE `message` ENABLE KEYS */;


-- 导出  表 sva.messagepush 结构
CREATE TABLE IF NOT EXISTS `messagepush` (
  `id` int(11) NOT NULL DEFAULT '0',
  `placeId` int(11) DEFAULT NULL,
  `floorNo` decimal(10,2) DEFAULT NULL,
  `pushRight` double DEFAULT NULL,
  `pushWrong` double DEFAULT NULL,
  `notPush` double DEFAULT NULL,
  `centerRadius` varchar(100) DEFAULT NULL,
  `centerReality` varchar(100) DEFAULT NULL,
  `isRigth` int(11) DEFAULT NULL,
  `updateTime` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 正在导出表  sva.messagepush 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `messagepush` DISABLE KEYS */;
/*!40000 ALTER TABLE `messagepush` ENABLE KEYS */;


-- 导出  表 sva.mwcprames 结构
CREATE TABLE IF NOT EXISTS `mwcprames` (
  `floorNo1` decimal(10,2) DEFAULT NULL,
  `floorNo2` decimal(10,2) DEFAULT NULL,
  `floorNo3` decimal(10,2) DEFAULT NULL,
  `floorNo4` decimal(10,2) DEFAULT NULL,
  `floorNo5` decimal(10,2) DEFAULT NULL,
  `floorNo6` decimal(10,2) DEFAULT NULL,
  `floorNo7` decimal(10,2) DEFAULT NULL,
  `floorNo8` decimal(10,2) DEFAULT NULL,
  `densitySel1` int(11) DEFAULT NULL,
  `densitySel2` int(11) DEFAULT NULL,
  `densitySel3` int(11) DEFAULT NULL,
  `densitySel4` int(11) DEFAULT NULL,
  `densitySel5` int(11) DEFAULT NULL,
  `startTime` datetime DEFAULT NULL,
  `densitySel6` int(11) DEFAULT NULL,
  `densitySel7` int(11) DEFAULT NULL,
  `densitySel8` int(11) DEFAULT NULL,
  `radiusSel1` int(11) DEFAULT NULL,
  `radiusSel2` int(11) DEFAULT NULL,
  `radiusSel3` int(11) DEFAULT NULL,
  `coefficient` int(11) DEFAULT NULL,
  `radiusSel4` int(11) DEFAULT NULL,
  `radiusSel5` int(11) DEFAULT NULL,
  `radiusSel6` int(11) DEFAULT NULL,
  `radiusSel7` int(11) DEFAULT NULL,
  `radiusSel8` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL DEFAULT '0',
  `periodSel` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 正在导出表  sva.mwcprames 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `mwcprames` DISABLE KEYS */;
/*!40000 ALTER TABLE `mwcprames` ENABLE KEYS */;


-- 导出  表 sva.nowpeople 结构
CREATE TABLE IF NOT EXISTS `nowpeople` (
  `areaName` varchar(50) NOT NULL,
  `areaId` int(11) NOT NULL,
  `placeId` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  PRIMARY KEY (`areaId`,`placeId`),
  CONSTRAINT `area_name` FOREIGN KEY (`areaId`) REFERENCES `area` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  sva.nowpeople 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `nowpeople` DISABLE KEYS */;
/*!40000 ALTER TABLE `nowpeople` ENABLE KEYS */;


-- 导出  表 sva.param 结构
CREATE TABLE IF NOT EXISTS `param` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `banThreshold` double(20,2) NOT NULL,
  `filterLength` double(20,2) NOT NULL,
  `horizontalWeight` double(20,2) unsigned NOT NULL,
  `ongitudinalWeight` double(20,2) NOT NULL,
  `maxDeviation` double(20,2) NOT NULL,
  `exceedMaxDeviation` double(20,2) NOT NULL,
  `updateTime` bigint(20) NOT NULL,
  `correctMapDirection` double(20,2) NOT NULL,
  `restTimes` double(20,2) NOT NULL,
  `step` double(20,2) NOT NULL,
  `filterPeakError` double(20,2) NOT NULL,
  `peakWidth` double(20,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  sva.param 的数据：~1 rows (大约)
/*!40000 ALTER TABLE `param` DISABLE KEYS */;
INSERT INTO `param` (`id`, `banThreshold`, `filterLength`, `horizontalWeight`, `ongitudinalWeight`, `maxDeviation`, `exceedMaxDeviation`, `updateTime`, `correctMapDirection`, `restTimes`, `step`, `filterPeakError`, `peakWidth`) VALUES
	(1, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1, 1.00, 1.00, 1.00, 1.00, 1.00);
/*!40000 ALTER TABLE `param` ENABLE KEYS */;


-- 导出  表 sva.phonenumber 结构
CREATE TABLE IF NOT EXISTS `phonenumber` (
  `ip` varchar(50) NOT NULL,
  `phoneNumber` varchar(50) DEFAULT NULL,
  `timestamp` bigint(20) NOT NULL,
  UNIQUE KEY `Index 1` (`ip`,`phoneNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  sva.phonenumber 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `phonenumber` DISABLE KEYS */;
/*!40000 ALTER TABLE `phonenumber` ENABLE KEYS */;


-- 导出  表 sva.prru 结构
CREATE TABLE IF NOT EXISTS `prru` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pRRUid` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `x` varchar(50) DEFAULT NULL,
  `y` varchar(50) DEFAULT NULL,
  `floorNo` decimal(10,2) DEFAULT NULL,
  `placeId` int(11) DEFAULT NULL,
  `neCode` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_prru_maps` (`floorNo`),
  KEY `FK_prru_store` (`placeId`),
  CONSTRAINT `FK_prru_maps` FOREIGN KEY (`floorNo`) REFERENCES `maps` (`floorNo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_prru_store` FOREIGN KEY (`placeId`) REFERENCES `store` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 正在导出表  sva.prru 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `prru` DISABLE KEYS */;
/*!40000 ALTER TABLE `prru` ENABLE KEYS */;


-- 导出  表 sva.prrusignal 结构
CREATE TABLE IF NOT EXISTS `prrusignal` (
  `id` int(11) NOT NULL,
  `gpp` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rsrp` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 正在导出表  sva.prrusignal 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `prrusignal` DISABLE KEYS */;
/*!40000 ALTER TABLE `prrusignal` ENABLE KEYS */;


-- 导出  表 sva.register 结构
CREATE TABLE IF NOT EXISTS `register` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`userId` VARCHAR(50) NULL DEFAULT NULL,
	`info` VARCHAR(50) NULL DEFAULT NULL,
	`userName` VARCHAR(50) NULL DEFAULT NULL,
	`loginStatus` VARCHAR(50) NULL DEFAULT NULL,
	`timestamp` BIGINT(20) NULL DEFAULT NULL,
	`status` INT(11) NULL DEFAULT '0',
	`password` VARCHAR(50) NULL DEFAULT NULL,
	`phoneNumber` BIGINT(20) NULL DEFAULT NULL,
	`role` INT(11) NULL DEFAULT NULL COMMENT '0:  1:  2:',
	`isTrue` INT(11) NULL DEFAULT '0',
	`otherPhone` VARCHAR(50) NULL DEFAULT NULL,
	UNIQUE INDEX `55555` (`phoneNumber`),
	INDEX `id` (`id`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=6;



-- 导出  表 sva.seller 结构
CREATE TABLE IF NOT EXISTS `seller` (
  `placeId` int(11) NOT NULL,
  `xSpot` decimal(10,2) NOT NULL,
  `ySpot` decimal(10,2) NOT NULL,
  `info` mediumtext CHARACTER SET utf8,
  `isEnable` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `pictruePath` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `moviePath` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `isVip` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `floorNo` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_seller_store` (`placeId`),
  KEY `FK_seller_maps` (`floorNo`),
  CONSTRAINT `FK_seller_maps` FOREIGN KEY (`floorNo`) REFERENCES `maps` (`floorNo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_seller_store` FOREIGN KEY (`placeId`) REFERENCES `store` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 正在导出表  sva.seller 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `seller` DISABLE KEYS */;
/*!40000 ALTER TABLE `seller` ENABLE KEYS */;


-- 导出  表 sva.staticaccuracy 结构
CREATE TABLE IF NOT EXISTS `staticaccuracy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `placeId` int(11) NOT NULL,
  `floorNo` decimal(10,2) NOT NULL,
  `origin` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `destination` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `avgeOffset` decimal(10,0) NOT NULL,
  `maxOffset` decimal(10,2) NOT NULL,
  `staicAccuracy` decimal(10,2) NOT NULL,
  `offsetCenter` decimal(10,2) NOT NULL,
  `offsetNumber` decimal(10,2) NOT NULL,
  `stability` decimal(10,0) NOT NULL,
  `count_3` int(11) NOT NULL,
  `count_5` int(11) NOT NULL,
  `count_10` int(11) NOT NULL,
  `count_10p` int(11) NOT NULL,
  `detail` text COLLATE utf8_unicode_ci,
  `triggerIp` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 正在导出表  sva.staticaccuracy 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `staticaccuracy` DISABLE KEYS */;
/*!40000 ALTER TABLE `staticaccuracy` ENABLE KEYS */;


-- 导出  表 sva.staticvisit 结构
CREATE TABLE IF NOT EXISTS `staticvisit` (
  `areaId` int(11) NOT NULL,
  `time` varchar(50) NOT NULL,
  `allTime` bigint(20) NOT NULL,
  `number` int(11) NOT NULL,
  `averageTime` bigint(20) NOT NULL,
  PRIMARY KEY (`areaId`,`time`),
  CONSTRAINT `areaId` FOREIGN KEY (`areaId`) REFERENCES `area` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 正在导出表  sva.staticvisit 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `staticvisit` DISABLE KEYS */;
/*!40000 ALTER TABLE `staticvisit` ENABLE KEYS */;


-- 导出  表 sva.statisticarea 结构
CREATE TABLE IF NOT EXISTS `statisticarea` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` datetime NOT NULL,
  `areaId` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 正在导出表  sva.statisticarea 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `statisticarea` DISABLE KEYS */;
/*!40000 ALTER TABLE `statisticarea` ENABLE KEYS */;


-- 导出  表 sva.statisticareaday 结构
CREATE TABLE IF NOT EXISTS `statisticareaday` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` datetime NOT NULL,
  `areaId` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 正在导出表  sva.statisticareaday 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `statisticareaday` DISABLE KEYS */;
/*!40000 ALTER TABLE `statisticareaday` ENABLE KEYS */;


-- 导出  表 sva.statisticday 结构
CREATE TABLE IF NOT EXISTS `statisticday` (
  `placeId` int(11) NOT NULL,
  `time` datetime NOT NULL,
  `number` int(11) DEFAULT NULL,
  PRIMARY KEY (`placeId`,`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 正在导出表  sva.statisticday 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `statisticday` DISABLE KEYS */;
/*!40000 ALTER TABLE `statisticday` ENABLE KEYS */;


-- 导出  表 sva.statisticfloor 结构
CREATE TABLE IF NOT EXISTS `statisticfloor` (
  `userID` varchar(50) CHARACTER SET utf8 NOT NULL,
  `time` datetime NOT NULL,
  `z` decimal(10,0) NOT NULL,
  PRIMARY KEY (`userID`,`time`,`z`),
  KEY `index` (`z`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 正在导出表  sva.statisticfloor 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `statisticfloor` DISABLE KEYS */;
/*!40000 ALTER TABLE `statisticfloor` ENABLE KEYS */;


-- 导出  表 sva.statistichour 结构
CREATE TABLE IF NOT EXISTS `statistichour` (
  `placeId` int(11) NOT NULL,
  `time` datetime NOT NULL,
  `number` int(11) DEFAULT NULL,
  PRIMARY KEY (`placeId`,`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 正在导出表  sva.statistichour 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `statistichour` DISABLE KEYS */;
/*!40000 ALTER TABLE `statistichour` ENABLE KEYS */;


-- 导出  表 sva.statisticlinetemp 结构
CREATE TABLE IF NOT EXISTS `statisticlinetemp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `placeId` int(11) NOT NULL,
  `time` datetime DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  sva.statisticlinetemp 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `statisticlinetemp` DISABLE KEYS */;
/*!40000 ALTER TABLE `statisticlinetemp` ENABLE KEYS */;


-- 导出  表 sva.statistictemp 结构
CREATE TABLE IF NOT EXISTS `statistictemp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT '0',
  `number` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  sva.statistictemp 的数据：~0 rows (大约)



-- 导出  表 sva.svalist 结构
CREATE TABLE IF NOT EXISTS `svalist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `ip` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `username` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `password` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `status` int(1) NOT NULL DEFAULT '0',
  `type` int(1) NOT NULL,
  `idType` VARCHAR(50) NOT NULL COMMENT 'IP,MAC,MSISDN' COLLATE 'utf8_unicode_ci',
  `tokenPort` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `brokerPort` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='sva列表';

-- 正在导出表  sva.svalist 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `svalist` DISABLE KEYS */;
/*!40000 ALTER TABLE `svalist` ENABLE KEYS */;


-- 导出  表 sva.svastoremap 结构
CREATE TABLE IF NOT EXISTS `svastoremap` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `svaId` int(11) DEFAULT '0',
  `storeId` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_svastoremap_svalist` (`svaId`),
  KEY `FK_svastoremap_store` (`storeId`),
  CONSTRAINT `FK_svastoremap_store` FOREIGN KEY (`storeId`) REFERENCES `store` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_svastoremap_svalist` FOREIGN KEY (`svaId`) REFERENCES `svalist` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `shprames` (
	`floorNo1` DECIMAL(10,2) NULL DEFAULT NULL,
	`floorNo2` DECIMAL(10,2) NULL DEFAULT NULL,
	`floorNo3` DECIMAL(10,2) NULL DEFAULT NULL,
	`densitySel1` INT(11) NULL DEFAULT NULL,
	`densitySel2` INT(11) NULL DEFAULT NULL,
	`densitySel3` INT(11) NULL DEFAULT NULL,
	`startTime` DATETIME NULL DEFAULT NULL,
	`radiusSel1` INT(11) NULL DEFAULT NULL,
	`radiusSel2` INT(11) NULL DEFAULT NULL,
	`radiusSel3` INT(11) NULL DEFAULT NULL,
	`id` INT(11) NOT NULL DEFAULT '0',
	`coefficient` INT(11) NOT NULL DEFAULT '0',
	`periodSel` INT(11) NULL DEFAULT NULL,
	PRIMARY KEY (`id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS `shpramesjing` (
    `floorNo1` DECIMAL(10,2) NULL DEFAULT NULL,
    `floorNo2` DECIMAL(10,2) NULL DEFAULT NULL,
    `floorNo3` DECIMAL(10,2) NULL DEFAULT NULL,
    `floorNo4` DECIMAL(10,2) NULL DEFAULT NULL,
    `densitySel1` INT(11) NULL DEFAULT NULL,
    `densitySel2` INT(11) NULL DEFAULT NULL,
    `densitySel3` INT(11) NULL DEFAULT NULL,
    `densitySel4` INT(11) NULL DEFAULT NULL,
    `startTime` DATETIME NULL DEFAULT NULL,
    `radiusSel1` INT(11) NULL DEFAULT NULL,
    `radiusSel2` INT(11) NULL DEFAULT NULL,
    `radiusSel3` INT(11) NULL DEFAULT NULL,
    `radiusSel4` INT(11) NULL DEFAULT NULL,
    `id` INT(11) NOT NULL DEFAULT '0',
    `coefficient` INT(11) NOT NULL DEFAULT '0',
    `periodSel` INT(11) NULL DEFAULT NULL,
    PRIMARY KEY (`id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `pushmsg` (
	`id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
	`userId` VARCHAR(50) NOT NULL DEFAULT '0' COMMENT '用户id',
	`content` VARCHAR(100) NULL DEFAULT '0' COMMENT '推送消息内容',
	PRIMARY KEY (`id`)
)
COMMENT='服务器端推送消息，一个userid对应多条消息'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=4;

CREATE TABLE IF NOT EXISTS `ticket` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`msgId` VARCHAR(50) NULL DEFAULT NULL,
	`chances` VARCHAR(50) NULL DEFAULT NULL,
	`ticketPath` VARCHAR(50) NULL DEFAULT NULL,
	PRIMARY KEY (`id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
AUTO_INCREMENT=9;

CREATE TABLE IF NOT EXISTS `website_visit` (
	`visitCount` INT(11) NULL DEFAULT '0',
	`ip` VARCHAR(50) NULL DEFAULT NULL,
	`last_visitTime` BIGINT(20) NULL DEFAULT NULL,
	`first_visitTime` BIGINT(20) NULL DEFAULT NULL,
	`userName` VARCHAR(50) NULL DEFAULT NULL,
	`iosCount` INT(11) NULL DEFAULT '0',
	`androidCount` INT(11) NULL DEFAULT '0',
	`webCount` INT(11) NULL DEFAULT '0'
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB;

