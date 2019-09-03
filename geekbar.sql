/*
Navicat MySQL Data Transfer

Source Server         : aliyun mysql
Source Server Version : 50727
Source Host           : 47.108.78.123:3306
Source Database       : geekbar

Target Server Type    : MYSQL
Target Server Version : 50727
File Encoding         : 65001

Date: 2019-09-03 11:49:14
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for app_access_log
-- ----------------------------
DROP TABLE IF EXISTS `app_access_log`;
CREATE TABLE `app_access_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) NOT NULL DEFAULT '0' COMMENT 'uid',
  `referer_url` varchar(255) NOT NULL DEFAULT '' COMMENT '当前访问的refer',
  `target_url` varchar(255) NOT NULL DEFAULT '' COMMENT '访问的url',
  `query_params` text NOT NULL COMMENT 'get和post参数',
  `ua` varchar(255) NOT NULL DEFAULT '' COMMENT '访问ua',
  `ip` varchar(32) NOT NULL DEFAULT '' COMMENT '访问ip',
  `note` varchar(1000) NOT NULL DEFAULT '' COMMENT 'json格式备注字段',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=3067 DEFAULT CHARSET=utf8mb4 COMMENT='用户访问记录表';

-- ----------------------------
-- Table structure for app_error_log
-- ----------------------------
DROP TABLE IF EXISTS `app_error_log`;
CREATE TABLE `app_error_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `referer_url` varchar(255) NOT NULL DEFAULT '' COMMENT '当前访问的refer',
  `target_url` varchar(255) NOT NULL DEFAULT '' COMMENT '访问的url',
  `query_params` text NOT NULL COMMENT 'get和post参数',
  `content` longtext NOT NULL COMMENT '日志内容',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '插入时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='app错误日表';

-- ----------------------------
-- Records of app_error_log
-- ----------------------------

-- ----------------------------
-- Table structure for banner
-- ----------------------------
DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner` (
  `id` int(11) NOT NULL COMMENT '主键id',
  `type` varchar(11) DEFAULT NULL COMMENT '类型：目前只有img',
  `url` varchar(500) DEFAULT NULL COMMENT '图片链接',
  `location_url` varchar(500) DEFAULT NULL COMMENT '图片的跳转url',
  `add_time` datetime DEFAULT NULL COMMENT '入库时间',
  `upd_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_delete` varchar(11) DEFAULT '0' COMMENT '是否删除：1：是 0：否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of banner
-- ----------------------------
INSERT INTO `banner` VALUES ('1', 'img', '20190812/37d131c9fd03461bbfe7e384eddf898a.jpg', 'http://www.baidu.com', '2019-07-28 22:17:24', '2019-07-28 22:17:29', '0');
INSERT INTO `banner` VALUES ('2', 'img', '20190812/d80df82b261e4c13af4d5d7d5d78066f.jpeg', null, '2019-07-28 22:18:17', '2019-07-28 22:18:22', '0');

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `bar_code` varchar(20) DEFAULT NULL COMMENT '条形码',
  `icon` varchar(500) DEFAULT NULL COMMENT '图标',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `desc` varchar(200) DEFAULT NULL COMMENT '描述',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `upd_time` datetime DEFAULT NULL COMMENT '更新时间',
  `all_num` varchar(11) DEFAULT NULL COMMENT '库存所有数量',
  `surplus_num` varchar(11) DEFAULT NULL COMMENT '剩余的数量',
  `star` varchar(11) DEFAULT NULL COMMENT '星级',
  `price` varchar(11) DEFAULT NULL COMMENT '单价',
  `is_delete` int(11) DEFAULT NULL COMMENT '是否删除：1：是 0：否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('12', '3057640117008', '20190818/284badac3aaa4c31972f560c8433ea07.png', 'Jaggermeister ', '', '2019-08-01 20:34:07', '2019-08-18 20:02:36', '0', '0', '0', '85.00', '0');
INSERT INTO `goods` VALUES ('13', '6901028118170', '20190815/ea1e769e92d042b39ac944c45737cbb8.jpg', 'Havana Club', '', '2019-08-01 22:03:58', '2019-08-15 15:54:21', '0', '0', '0', '100.00', '0');
INSERT INTO `goods` VALUES ('14', '3012992421005', '20190815/7784e461185a4f0d8c6f8f0165e45a02.png', 'Beefeater Gin', '', '2019-08-03 22:19:45', '2019-08-15 21:05:37', '0', '0', '0', '120.00', '0');
INSERT INTO `goods` VALUES ('54', '123123123', '20190815/2065757e1e45494da699c1e958469130.jpg', 'Bulleit Bourbon', '', '2019-08-15 08:28:31', '2019-08-15 08:56:12', '0', '0', '0', '123.00', '1');
INSERT INTO `goods` VALUES ('55', '088110110505', '20190818/9cee1b5a53d148b6931fd500e3ce9985.png', 'Tanqueray', '', '2019-08-15 21:33:32', '2019-08-18 20:04:32', '0', '0', '0', '86.00', '0');
INSERT INTO `goods` VALUES ('56', '3035540002198', '20190818/6e977bbbd8164beaaca55ed2a83b7eb2.png', 'Cointreau ', '', '2019-08-15 21:39:21', '2019-08-18 23:58:42', '0', '0', '0', '85.00', '0');
INSERT INTO `goods` VALUES ('57', '3035540002198', '20190815/1ee3c92dc7dd47108773f5ba3996c52b.png', 'Cointreau ', '', '2019-08-15 21:40:41', '2019-08-15 21:40:41', '0', '0', '0', '85.00', '1');
INSERT INTO `goods` VALUES ('58', '835229000308', '20190818/4cbc1d1f4e704db8b0b424f18c723fcb.png', 'Absolut Vodka', '', '2019-08-15 21:42:11', '2019-08-18 20:08:00', '0', '0', '0', '110.00', '0');
INSERT INTO `goods` VALUES ('59', '1121', '20190816/d3b078a8705c4e35aff2efde10ce7ac0.jpg', 'Capi Grapefruit', '', '2019-08-16 15:23:49', '2019-08-16 15:36:51', '0', '0', '0', '45.00', '0');
INSERT INTO `goods` VALUES ('60', '082000752967', '20190818/5d1a804b86e247f9938108d4d80c006d.png', 'Bulleit Rye', '', '2019-08-18 19:46:54', '2019-08-18 19:46:54', '0', '0', '0', '250.00', '0');
INSERT INTO `goods` VALUES ('61', '082000765578', '20190818/1c140892480d4729a59378538ab1a5d9.png', 'Bulleit Bourbon', '', '2019-08-18 19:59:22', '2019-08-18 19:59:22', '0', '0', '0', '300.00', '0');
INSERT INTO `goods` VALUES ('62', '088857001814', '20190818/c5bef77a9b9248c2b0a9cb60d81d3e84.png', 'Hakushu 12', '', '2019-08-18 20:16:09', '2019-08-18 20:16:09', '0', '0', '0', '400.00', '0');
INSERT INTO `goods` VALUES ('63', '088857001616', '20190818/1744cc20682a48dabce18c9412025238.png', 'Yamazaki 12', '', '2019-08-18 20:16:57', '2019-08-18 20:16:57', '0', '0', '0', '754.00', '0');
INSERT INTO `goods` VALUES ('64', ' 5000281005430', '20190818/da34afdc2c3c464fa9dc284165c42639.png', 'Cragganmore 12', '', '2019-08-18 20:23:47', '2019-08-18 20:23:47', '0', '0', '0', '250.00', '0');
INSERT INTO `goods` VALUES ('65', '123123', '20190818/51f8bc987e0d430aaa46076aa18336b2.jpg', '123', '', '2019-08-18 20:56:13', '2019-08-18 20:56:13', '0', '0', '0', '123.00', '1');
INSERT INTO `goods` VALUES ('66', ' 5010196111010', '20190818/a99784ac9cda4a199ca7fdeb00cfaf8a.png', 'Dalmore 12Y', '', '2019-08-18 23:17:30', '2019-08-18 23:17:30', '0', '0', '0', '300.00', '0');
INSERT INTO `goods` VALUES ('67', '7401005008580', '20190818/39e618a2f47343e888094004b4e165ca.png', 'Zacapa 23', '', '2019-08-18 23:25:40', '2019-08-18 23:25:40', '0', '0', '0', '250.00', '0');
INSERT INTO `goods` VALUES ('68', '0634324891909', '20190902/f4ad8b1393a34db1a1f70ab2664af905.png', 'Few Bourbon', '', '2019-08-18 23:26:51', '2019-09-02 10:55:08', '0', '0', '0', '450.00', '0');
INSERT INTO `goods` VALUES ('69', '0812066020553', '20190902/1e46fd59b7d74c53837893c18467baa7.png', 'Macallan 12', '', '2019-08-18 23:27:33', '2019-09-02 10:53:48', '0', '0', '0', '460.00', '0');
INSERT INTO `goods` VALUES ('70', '0813219020048', '20190902/48cd7290ce204f9fb9271777f8834f1d.png', 'Teeling Whiskey', '', '2019-08-18 23:29:32', '2019-09-02 10:52:15', '0', '0', '0', '235.00', '0');
INSERT INTO `goods` VALUES ('71', '5000281020761', '20190902/0ee184ca58054401ab608ec22ae200e9.png', 'Tanqueray 10', '', '2019-08-18 23:30:11', '2019-09-02 10:51:15', '0', '0', '0', '340.00', '0');
INSERT INTO `goods` VALUES ('72', '5021944085781', '20190902/5e18a2bc65ff4dabbb5acd9630a66d75.png', 'Tamdhu 10Y', '', '2019-08-18 23:31:22', '2019-09-02 10:50:55', '0', '0', '0', '123.00', '0');
INSERT INTO `goods` VALUES ('73', '0088110170059', '20190902/9315fa8f752d469eaaefda8dcef8a68c.png', 'Talisker 10Y', '', '2019-08-18 23:59:45', '2019-09-02 10:50:29', '0', '0', '0', '300.00', '0');
INSERT INTO `goods` VALUES ('74', ' 5000281042480', '20190902/db0c1283f22b459787286a675ceceec9.png', 'Singleton 12Y', '', '2019-08-19 00:00:58', '2019-09-02 10:48:26', '0', '0', '0', '259.00', '0');
INSERT INTO `goods` VALUES ('75', '5010739197006', '20190902/9b87f1da89a847bfa607e74029bef146.png', 'Aberlour 10Y', '', '2019-08-19 00:03:11', '2019-09-02 10:48:04', '0', '0', '0', '349.00', '0');
INSERT INTO `goods` VALUES ('76', '0041508634489', '20190902/141e26f1a0174986bc7ef7b9f175e2b3.jpg', 'Panna Water', '', '2019-08-19 00:04:08', '2019-09-02 10:47:35', '0', '0', '0', '345.00', '0');
INSERT INTO `goods` VALUES ('77', '5000281005447', '20190902/c72288fd5f4a4e3d8042de3b17088ed7.png', 'Oban 14', '', '2019-08-19 15:53:45', '2019-09-02 10:47:14', '0', '0', '0', '345.00', '0');
INSERT INTO `goods` VALUES ('78', '0080432101261', '20190902/88790cc7ace74c4799bd0d4d95321216.png', 'Martell Noblige', '', '2019-08-19 15:54:55', '2019-09-02 10:46:54', '0', '0', '0', '340.00', '0');
INSERT INTO `goods` VALUES ('79', '343242355', '20190902/6826cf0faf284c51a64d896ad711922c.png', 'London no 1', '', '2019-08-19 15:56:57', '2019-09-02 10:46:21', '0', '0', '0', '350.00', '0');
INSERT INTO `goods` VALUES ('80', '56445645', '20190902/220bc3f5f6544ed0b666a60158b15b0f.png', 'Le Tribute Gin', '', '2019-08-19 15:57:54', '2019-09-02 10:45:37', '0', '0', '0', '450.00', '0');
INSERT INTO `goods` VALUES ('81', '5000281005409', '20190902/fe84d68336eb4bbb84bb915c97d3ff51.png', 'Lagavulin 16', '', '2019-08-19 15:58:32', '2019-09-02 10:45:15', '0', '0', '0', '568.00', '0');

-- ----------------------------
-- Table structure for images
-- ----------------------------
DROP TABLE IF EXISTS `images`;
CREATE TABLE `images` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `file_key` varchar(60) NOT NULL DEFAULT '' COMMENT '文件名',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '插入时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of images
-- ----------------------------
INSERT INTO `images` VALUES ('33', '20190812/37d131c9fd03461bbfe7e384eddf898a.jpeg', '2019-08-12 21:29:15');
INSERT INTO `images` VALUES ('34', '20190812/d80df82b261e4c13af4d5d7d5d78066f.jpeg', '2019-08-12 21:29:20');
INSERT INTO `images` VALUES ('35', '20190813/9820a38e221c4d3c8f0cf43a1d49836f.png', '2019-08-13 18:37:19');
INSERT INTO `images` VALUES ('36', '20190815/0fffdde3ae4348a998283e177e3bd700.png', '2019-08-15 08:28:29');
INSERT INTO `images` VALUES ('37', '20190815/7504f9021eed4a39ac9cfd5e75bb21cf.png', '2019-08-15 08:29:50');
INSERT INTO `images` VALUES ('38', '20190815/b5e7ca6b6b5948ba958a8df6b762ed62.png', '2019-08-15 08:54:55');
INSERT INTO `images` VALUES ('39', '20190815/2065757e1e45494da699c1e958469130.jpg', '2019-08-15 08:56:11');
INSERT INTO `images` VALUES ('40', '20190815/01b685714e8a4283b37c01de4e40140d.jpg', '2019-08-15 08:56:19');
INSERT INTO `images` VALUES ('41', '20190815/ef25e3cb32674b058ff8bfd0f44cccc6.jpg', '2019-08-15 15:38:58');
INSERT INTO `images` VALUES ('42', '20190815/f01d7a6426d445da9a0e21b0e5b5fb2e.jpg', '2019-08-15 15:45:29');
INSERT INTO `images` VALUES ('43', '20190815/ea1e769e92d042b39ac944c45737cbb8.jpg', '2019-08-15 15:52:25');
INSERT INTO `images` VALUES ('44', '20190815/7784e461185a4f0d8c6f8f0165e45a02.png', '2019-08-15 21:05:27');
INSERT INTO `images` VALUES ('45', '20190815/878d08e041d04450afa850dd82ed6eee.png', '2019-08-15 21:33:18');
INSERT INTO `images` VALUES ('46', '20190815/1ee3c92dc7dd47108773f5ba3996c52b.png', '2019-08-15 21:36:17');
INSERT INTO `images` VALUES ('47', '20190815/7ccd7755b692473fa9c847e788ac7524.png', '2019-08-15 21:42:00');
INSERT INTO `images` VALUES ('48', '20190816/2221f4ce389c41b6afa622b9a61d0b1d.png', '2019-08-16 15:23:35');
INSERT INTO `images` VALUES ('49', '20190816/d3b078a8705c4e35aff2efde10ce7ac0.jpg', '2019-08-16 15:33:46');
INSERT INTO `images` VALUES ('50', '20190816/e16e7f77d20148ec8836106bcfc0102a.jpg', '2019-08-16 15:37:06');
INSERT INTO `images` VALUES ('51', '20190818/5d1a804b86e247f9938108d4d80c006d.png', '2019-08-18 19:46:11');
INSERT INTO `images` VALUES ('52', '20190818/1c140892480d4729a59378538ab1a5d9.png', '2019-08-18 19:58:28');
INSERT INTO `images` VALUES ('53', '20190818/284badac3aaa4c31972f560c8433ea07.png', '2019-08-18 20:02:23');
INSERT INTO `images` VALUES ('54', '20190818/9cee1b5a53d148b6931fd500e3ce9985.png', '2019-08-18 20:04:22');
INSERT INTO `images` VALUES ('55', '20190818/4cbc1d1f4e704db8b0b424f18c723fcb.png', '2019-08-18 20:07:31');
INSERT INTO `images` VALUES ('56', '20190818/5320f42334d24f0198ec8fe8cb4a9945.png', '2019-08-18 20:09:55');
INSERT INTO `images` VALUES ('57', '20190818/c5bef77a9b9248c2b0a9cb60d81d3e84.png', '2019-08-18 20:15:28');
INSERT INTO `images` VALUES ('58', '20190818/1744cc20682a48dabce18c9412025238.png', '2019-08-18 20:16:32');
INSERT INTO `images` VALUES ('59', '20190818/da34afdc2c3c464fa9dc284165c42639.png', '2019-08-18 20:22:22');
INSERT INTO `images` VALUES ('60', '20190818/51f8bc987e0d430aaa46076aa18336b2.jpg', '2019-08-18 20:56:05');
INSERT INTO `images` VALUES ('61', '20190818/a99784ac9cda4a199ca7fdeb00cfaf8a.png', '2019-08-18 23:14:49');
INSERT INTO `images` VALUES ('62', '20190818/39e618a2f47343e888094004b4e165ca.png', '2019-08-18 23:17:50');
INSERT INTO `images` VALUES ('63', '20190818/39c0e92510c4412bba07958a1e538f73.png', '2019-08-18 23:26:25');
INSERT INTO `images` VALUES ('64', '20190818/8acb3b41891d4f7e83427ea81a2511e4.png', '2019-08-18 23:27:03');
INSERT INTO `images` VALUES ('65', '20190818/f77a1dc23f3247b3af462ea2135579ba.png', '2019-08-18 23:27:55');
INSERT INTO `images` VALUES ('66', '20190818/7659576226094651a77382aa7b861ad4.png', '2019-08-18 23:29:49');
INSERT INTO `images` VALUES ('67', '20190818/26d0f5f6738b41909f2172c9979d9918.png', '2019-08-18 23:30:28');
INSERT INTO `images` VALUES ('68', '20190818/6e977bbbd8164beaaca55ed2a83b7eb2.png', '2019-08-18 23:58:36');
INSERT INTO `images` VALUES ('69', '20190818/fb429c43ab8944eabd60373218d36592.png', '2019-08-18 23:59:26');
INSERT INTO `images` VALUES ('70', '20190819/e61c2bb27f1b438eb093ca3fb4c5d5dc.png', '2019-08-19 00:00:08');
INSERT INTO `images` VALUES ('71', '20190819/4dc9ed586d84404bbd152e63ebcc4573.png', '2019-08-19 00:01:37');
INSERT INTO `images` VALUES ('72', '20190819/515e6086f2594c889cc40e6196176670.jpg', '2019-08-19 00:04:00');
INSERT INTO `images` VALUES ('73', '20190819/ba056e1ec9cf410b92f94368469cafc6.png', '2019-08-19 15:53:17');
INSERT INTO `images` VALUES ('74', '20190819/7065fa2e57704cff89a19f2d0d0282e8.png', '2019-08-19 15:54:08');
INSERT INTO `images` VALUES ('75', '20190819/eb46d431441244e79f1592dec14f468e.png', '2019-08-19 15:55:34');
INSERT INTO `images` VALUES ('76', '20190819/2ec877cab2f14a7c8886173e594613ba.png', '2019-08-19 15:57:17');
INSERT INTO `images` VALUES ('77', '20190819/a50ddf418eab463394d8c4f968d210a8.png', '2019-08-19 15:58:08');
INSERT INTO `images` VALUES ('78', '20190829/400572355c26412885d2515d7bab5692.pdf', '2019-08-29 18:24:35');
INSERT INTO `images` VALUES ('79', '20190901/db83f6a10a954a0993e8b43fc0f14ade.jpg', '2019-09-01 17:34:36');
INSERT INTO `images` VALUES ('80', '20190901/eceb735c640c482e8d5d6048e700f614.png', '2019-09-01 17:52:59');
INSERT INTO `images` VALUES ('81', '20190901/631460b639c342adbfc3c2d6827f75ef.png', '2019-09-01 22:23:51');
INSERT INTO `images` VALUES ('82', '20190901/8b066f4d12b34780b4eee44dd10da3df.jpg', '2019-09-01 22:25:30');
INSERT INTO `images` VALUES ('83', '20190902/fe84d68336eb4bbb84bb915c97d3ff51.png', '2019-09-02 10:45:05');
INSERT INTO `images` VALUES ('84', '20190902/220bc3f5f6544ed0b666a60158b15b0f.png', '2019-09-02 10:45:31');
INSERT INTO `images` VALUES ('85', '20190902/6826cf0faf284c51a64d896ad711922c.png', '2019-09-02 10:45:50');
INSERT INTO `images` VALUES ('86', '20190902/88790cc7ace74c4799bd0d4d95321216.png', '2019-09-02 10:46:37');
INSERT INTO `images` VALUES ('87', '20190902/c72288fd5f4a4e3d8042de3b17088ed7.png', '2019-09-02 10:47:10');
INSERT INTO `images` VALUES ('88', '20190902/141e26f1a0174986bc7ef7b9f175e2b3.jpg', '2019-09-02 10:47:33');
INSERT INTO `images` VALUES ('89', '20190902/9b87f1da89a847bfa607e74029bef146.png', '2019-09-02 10:47:58');
INSERT INTO `images` VALUES ('90', '20190902/db0c1283f22b459787286a675ceceec9.png', '2019-09-02 10:48:19');
INSERT INTO `images` VALUES ('91', '20190902/9315fa8f752d469eaaefda8dcef8a68c.png', '2019-09-02 10:48:40');
INSERT INTO `images` VALUES ('92', '20190902/5e18a2bc65ff4dabbb5acd9630a66d75.png', '2019-09-02 10:50:47');
INSERT INTO `images` VALUES ('93', '20190902/0ee184ca58054401ab608ec22ae200e9.png', '2019-09-02 10:51:10');
INSERT INTO `images` VALUES ('94', '20190902/14cd849711f442369d484b11d90e6a7c.png', '2019-09-02 10:51:31');
INSERT INTO `images` VALUES ('95', '20190902/48cd7290ce204f9fb9271777f8834f1d.png', '2019-09-02 10:51:54');
INSERT INTO `images` VALUES ('96', '20190902/1e46fd59b7d74c53837893c18467baa7.png', '2019-09-02 10:53:13');
INSERT INTO `images` VALUES ('97', '20190902/f4ad8b1393a34db1a1f70ab2664af905.png', '2019-09-02 10:54:45');
INSERT INTO `images` VALUES ('98', '20190902/b0fa97ec04794475b8e70ccdd05b5f83.png', '2019-09-02 11:02:00');
INSERT INTO `images` VALUES ('99', '20190903/e4a5da0703424650b4978459154819d5.png', '2019-09-03 05:52:52');
INSERT INTO `images` VALUES ('100', '20190903/e17a876ce6e1455d8b1b3afdd4de2af3.jpg', '2019-09-03 08:09:51');
INSERT INTO `images` VALUES ('101', '20190903/04fa606101e94b51a8fe457f97bec596.png', '2019-09-03 08:09:56');
INSERT INTO `images` VALUES ('102', '20190903/a3d946894281457e8dcffb2efa0aafa5.png', '2019-09-03 08:10:00');
INSERT INTO `images` VALUES ('103', '20190903/8fe434061bc242efa9a0f3fe2f0a4589.png', '2019-09-03 08:10:07');

-- ----------------------------
-- Table structure for invoice
-- ----------------------------
DROP TABLE IF EXISTS `invoice`;
CREATE TABLE `invoice` (
  `invoice_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `address` varchar(100) DEFAULT NULL COMMENT '地址',
  `phone` varchar(20) DEFAULT NULL COMMENT '电话',
  `amount` decimal(12,2) NOT NULL COMMENT '金额',
  `notes` varchar(200) DEFAULT NULL COMMENT '文件地址',
  `status` tinyint(4) DEFAULT '0' COMMENT '订单状态( 0已创建Sent，1待发送Pending，2-已经扫码,完成Receivd)',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `group_name` varchar(255) DEFAULT NULL COMMENT '分组名',
  `file_path` varchar(255) DEFAULT NULL COMMENT '文件路径',
  `del_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1:删除 0:未删除',
  `order_id` int(11) DEFAULT NULL COMMENT '订单号',
  `mid` int(11) DEFAULT NULL COMMENT '用户id member',
  `goods_id` int(11) DEFAULT NULL COMMENT '货物id',
  PRIMARY KEY (`invoice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COMMENT='发票表';

-- ----------------------------
-- Records of invoice
-- ----------------------------
INSERT INTO `invoice` VALUES ('105', null, null, '1.00', '2', '0', '2019-08-29 18:24:38', '2019-08-29 18:24:38', null, '20190829/400572355c26412885d2515d7bab5692.png', '0', null, null, null);
INSERT INTO `invoice` VALUES ('106', null, null, '1.00', '1', '2', '2019-09-01 17:34:39', '2019-09-01 17:52:04', 'samigroup', '20190901/db83f6a10a954a0993e8b43fc0f14ade.jpg', '0', null, '24', null);
INSERT INTO `invoice` VALUES ('107', null, null, '12.00', '照相机', '2', '2019-09-01 17:53:10', '2019-09-01 20:09:23', 'samigroup', '20190901/eceb735c640c482e8d5d6048e700f614.png', '0', null, '23', null);
INSERT INTO `invoice` VALUES ('108', null, null, '546.00', 'Test', '2', '2019-09-01 22:24:00', '2019-09-01 22:25:35', 'samigroup', '20190901/631460b639c342adbfc3c2d6827f75ef.png', '0', null, '23', null);
INSERT INTO `invoice` VALUES ('109', null, null, '1121.00', '1', '2', '2019-09-02 11:02:09', '2019-09-02 11:25:34', 'samigroup', '20190902/b0fa97ec04794475b8e70ccdd05b5f83.png', '0', null, '24', null);
INSERT INTO `invoice` VALUES ('110', null, null, '847.00', '', '2', '2019-09-03 05:52:59', '2019-09-03 05:53:33', 'samigroup', '20190903/e4a5da0703424650b4978459154819d5.png', '0', null, '23', null);

-- ----------------------------
-- Table structure for invoice_evaluate
-- ----------------------------
DROP TABLE IF EXISTS `invoice_evaluate`;
CREATE TABLE `invoice_evaluate` (
  `evaluate_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `invoice_id` int(11) NOT NULL COMMENT '发票主键Id',
  `evaluate_star_level1` int(11) NOT NULL DEFAULT '0' COMMENT '评价星级1',
  `evaluate_star_level2` int(11) NOT NULL DEFAULT '0' COMMENT '评价星级2',
  `evaluate_content` varchar(500) DEFAULT NULL COMMENT '评价内容',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1:删除 0:未删除',
  PRIMARY KEY (`evaluate_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COMMENT='评价表';

-- ----------------------------
-- Records of invoice_evaluate
-- ----------------------------
INSERT INTO `invoice_evaluate` VALUES ('12', '106', '5', '5', '1', '2019-09-01 17:35:05', '2019-09-01 17:35:05', '0');
INSERT INTO `invoice_evaluate` VALUES ('13', '107', '2', '3', 'good delivery', '2019-09-01 20:09:24', '2019-09-01 20:09:24', '0');
INSERT INTO `invoice_evaluate` VALUES ('15', '108', '5', '5', 'good ', '2019-09-01 22:25:35', '2019-09-01 22:25:35', '0');
INSERT INTO `invoice_evaluate` VALUES ('17', '109', '4', '4', 'good', '2019-09-02 11:25:34', '2019-09-02 11:25:34', '0');
INSERT INTO `invoice_evaluate` VALUES ('21', '110', '3', '5', '', '2019-09-03 05:53:33', '2019-09-03 05:53:33', '0');

-- ----------------------------
-- Table structure for invoice_evaluate_img
-- ----------------------------
DROP TABLE IF EXISTS `invoice_evaluate_img`;
CREATE TABLE `invoice_evaluate_img` (
  `invoice_evaluate_img_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `invoice_id` int(11) NOT NULL COMMENT '发票主键Id',
  `evaluate_id` int(11) NOT NULL COMMENT '评价主键Id',
  `file_key` varchar(60) NOT NULL DEFAULT '' COMMENT '文件名',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1:删除 0:未删除',
  PRIMARY KEY (`invoice_evaluate_img_id`)
) ENGINE=InnoDB AUTO_INCREMENT=421 DEFAULT CHARSET=utf8mb4 COMMENT='评价图片表';

-- ----------------------------
-- Records of invoice_evaluate_img
-- ----------------------------
INSERT INTO `invoice_evaluate_img` VALUES ('419', '108', '15', '20190901/8b066f4d12b34780b4eee44dd10da3df.jpg', '2019-09-01 22:25:35', '2019-09-01 22:25:35', '0');

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nickname` varchar(100) NOT NULL DEFAULT '' COMMENT '会员名',
  `mobile` varchar(11) NOT NULL DEFAULT '' COMMENT '会员手机号码',
  `sex` tinyint(1) NOT NULL DEFAULT '0' COMMENT '性别 1：男 2：女',
  `avatar` varchar(200) NOT NULL DEFAULT '' COMMENT '会员头像',
  `salt` varchar(32) NOT NULL DEFAULT '' COMMENT '随机salt',
  `reg_ip` varchar(100) NOT NULL DEFAULT '' COMMENT '注册ip',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 1：有效 0：无效',
  `updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次更新时间',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '插入时间',
  `group_name` varchar(255) DEFAULT NULL COMMENT '分组名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COMMENT='会员表';

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES ('23', 'Sami', '', '1', 'https://wx.qlogo.cn/mmopen/vi_32/9XIuCvJHLwzksK5kZgRYjiccB8rzhcVeJtibdKysjczsG0X7ucSMAVxV1d1yg4ENic7HcMTz8D0mYjKRPzkbZd3ibg/132', 'SvLEKr552FvYMwbw', '', '1', '2019-09-01 17:48:09', '2019-08-13 17:57:27', 'samigroup');
INSERT INTO `member` VALUES ('24', '岳', '', '1', 'https://wx.qlogo.cn/mmopen/vi_32/ajNVdqHZLLCgfXASJ4XmS7dNBRPC09wshv1Xib8gkhRE4AI7zeNLpETxPqAE2ibSATSxvUt3JlnAOQ0EIls7R92g/132', 'P6FY1EpPTgn2XPND', '', '1', '2019-09-01 17:48:04', '2019-08-13 17:58:06', 'samigroup');
INSERT INTO `member` VALUES ('25', '杨俊霖', '', '0', 'https://wx.qlogo.cn/mmhead/r6UlBX94vTTia1j3RTe3MSDusb6NVrFiaCOo5guRGcLT0/132', 'zae1W3T8AtRq4lSj', '', '1', '2019-09-02 16:12:14', '2019-09-02 16:12:14', null);

-- ----------------------------
-- Table structure for oauth_member_bind
-- ----------------------------
DROP TABLE IF EXISTS `oauth_member_bind`;
CREATE TABLE `oauth_member_bind` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '会员id',
  `client_type` varchar(20) NOT NULL DEFAULT '' COMMENT '客户端来源类型。qq,weibo,weixin',
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '类型 type 1:wechat ',
  `openid` varchar(80) NOT NULL DEFAULT '' COMMENT '第三方id',
  `unionid` varchar(100) NOT NULL DEFAULT '',
  `extra` text NOT NULL COMMENT '额外字段',
  `updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '插入时间',
  PRIMARY KEY (`id`),
  KEY `idx_type_openid` (`type`,`openid`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COMMENT='第三方登录绑定关系';

-- ----------------------------
-- Records of oauth_member_bind
-- ----------------------------
INSERT INTO `oauth_member_bind` VALUES ('23', '23', '', '1', 'o_VY_5YT4b47lY7wvBDgPjUSnccY', '', '', '2019-08-13 17:57:27', '2019-08-13 17:57:27');
INSERT INTO `oauth_member_bind` VALUES ('24', '24', '', '1', 'o_VY_5blEXCQJcZIsoOrAd1g5FIk', '', '', '2019-08-13 17:58:06', '2019-08-13 17:58:06');
INSERT INTO `oauth_member_bind` VALUES ('25', '25', '', '1', 'o_VY_5cPXdzRoF1DqZlBz5kQaAN8', '', '', '2019-09-02 16:12:14', '2019-09-02 16:12:14');

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `mid` int(11) NOT NULL COMMENT '用户id member',
  `goods_id` int(11) DEFAULT NULL COMMENT '货物id',
  `int_num` varchar(20) DEFAULT NULL COMMENT '整瓶数',
  `per_num` varchar(20) DEFAULT NULL COMMENT '非整瓶数',
  `price` varchar(20) DEFAULT NULL COMMENT '单价',
  `all_price` varchar(20) DEFAULT NULL COMMENT '总价',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `upd_time` datetime DEFAULT NULL COMMENT '更新时间',
  `order_id` varchar(50) DEFAULT NULL COMMENT '订单号',
  `name` varchar(20) DEFAULT NULL COMMENT '货物名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=560 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES ('161', '23', '14', '0', '0.6', '120.00', '72.00', '2019-08-13 17:57:58', '2019-08-13 17:57:58', '201908131757584651494', 'Sir Edward\'s Scotch');
INSERT INTO `order` VALUES ('162', '23', '13', '5', '0.6', '100.00', '5060.00', '2019-08-13 17:58:12', '2019-08-13 17:58:12', '201908131758111845542', 'Havana Club');
INSERT INTO `order` VALUES ('163', '23', '14', '3', '0.6', '120.00', '432.00', '2019-08-13 17:59:03', '2019-08-13 17:59:03', '201908131759022833797', 'Sir Edward\'s Scotch');
INSERT INTO `order` VALUES ('164', '23', '14', '3', '0.6', '120.00', '432.00', '2019-08-13 17:59:04', '2019-08-13 17:59:04', '201908131759044065681', 'Sir Edward\'s Scotch');
INSERT INTO `order` VALUES ('165', '23', '14', '3', '0.8', '120.00', '456.00', '2019-08-13 17:59:13', '2019-08-13 17:59:13', '201908131759129712765', 'Sir Edward\'s Scotch');
INSERT INTO `order` VALUES ('166', '23', '14', '3', '0.4', '120.00', '408.00', '2019-08-13 17:59:30', '2019-08-13 17:59:30', '201908131759304805264', 'Sir Edward\'s Scotch');
INSERT INTO `order` VALUES ('167', '23', '12', '3', '0.3', '12.00', '39.60', '2019-08-13 18:00:47', '2019-08-13 18:00:47', '201908131800472847068', 'Volvic 50cl');
INSERT INTO `order` VALUES ('168', '23', '13', '3', '0.7', '100.00', '370.00', '2019-08-13 18:00:56', '2019-08-13 18:00:56', '201908131800555921185', 'Havana Club');
INSERT INTO `order` VALUES ('169', '23', '14', '3', '0.3', '120.00', '396.00', '2019-08-13 18:01:03', '2019-08-13 18:01:03', '201908131801029495227', 'Sir Edward\'s Scotch');
INSERT INTO `order` VALUES ('170', '23', '12', '3', '0.5', '12.00', '42.00', '2019-08-13 18:06:06', '2019-08-13 18:06:06', '201908131806055431805', 'Volvic 50cl');
INSERT INTO `order` VALUES ('173', '23', '28', '3', '0.0', '12.00', '36.00', '2019-08-14 15:11:25', '2019-08-14 15:11:25', '201908141511249362311', 'Volvic 50cl');
INSERT INTO `order` VALUES ('174', '23', '53', '3', '0.0', '100.00', '300.00', '2019-08-14 15:12:02', '2019-08-14 15:12:02', '201908141512024054344', 'Havana Club');
INSERT INTO `order` VALUES ('175', '23', '52', '3', '0.0', '12.00', '36.00', '2019-08-14 15:12:20', '2019-08-14 15:12:20', '201908141512196401708', 'Volvic 50cl');
INSERT INTO `order` VALUES ('179', '23', '12', '2', '0.0', '12.00', '24.00', '2019-08-15 17:11:07', '2019-08-15 17:11:07', '201908151711071977026', 'Volvic 50cl');
INSERT INTO `order` VALUES ('233', '23', '13', '4.7', '0.0', '100.00', '470.00', '2019-08-16 13:51:19', '2019-08-16 13:51:19', '201908161351191693604', 'Havana Club');
INSERT INTO `order` VALUES ('234', '23', '13', '5.7', '0.0', '100.00', '570.00', '2019-08-16 13:51:20', '2019-08-16 13:51:20', '201908161351201004746', 'Havana Club');
INSERT INTO `order` VALUES ('235', '23', '13', '6.7', '0.0', '100.00', '670.00', '2019-08-16 13:51:23', '2019-08-16 13:51:23', '201908161351234808252', 'Havana Club');
INSERT INTO `order` VALUES ('236', '23', '13', '7.7', '0.0', '100.00', '770.00', '2019-08-16 13:51:24', '2019-08-16 13:51:24', '201908161351242705588', 'Havana Club');
INSERT INTO `order` VALUES ('237', '23', '55', '1', '0.0', '86.00', '86.00', '2019-08-16 13:51:29', '2019-08-16 13:51:29', '201908161351290030851', 'Tanqueray');
INSERT INTO `order` VALUES ('238', '23', '55', '2', '0.0', '86.00', '172.00', '2019-08-16 13:51:30', '2019-08-16 13:51:30', '201908161351299801505', 'Tanqueray');
INSERT INTO `order` VALUES ('239', '23', '55', '3', '0.0', '86.00', '258.00', '2019-08-16 13:51:33', '2019-08-16 13:51:33', '201908161351329419496', 'Tanqueray');
INSERT INTO `order` VALUES ('251', '23', '13', '8.7', '0.0', '100.00', '870.00', '2019-08-16 14:02:30', '2019-08-16 14:02:30', '201908161402295304875', 'Havana Club');
INSERT INTO `order` VALUES ('252', '23', '13', '9.7', '0.0', '100.00', '970.00', '2019-08-16 14:02:31', '2019-08-16 14:02:31', '201908161402307293699', 'Havana Club');
INSERT INTO `order` VALUES ('253', '23', '13', '10.7', '0.0', '100.00', '1070.00', '2019-08-16 14:02:33', '2019-08-16 14:02:33', '201908161402329726954', 'Havana Club');
INSERT INTO `order` VALUES ('254', '23', '13', '11.7', '0.0', '100.00', '1170.00', '2019-08-16 14:02:34', '2019-08-16 14:02:34', '201908161402338637104', 'Havana Club');
INSERT INTO `order` VALUES ('255', '23', '13', '12.7', '0.0', '100.00', '1270.00', '2019-08-16 14:02:35', '2019-08-16 14:02:35', '201908161402348724792', 'Havana Club');
INSERT INTO `order` VALUES ('256', '23', '13', '13.7', '0.0', '100.00', '1370.00', '2019-08-16 14:02:36', '2019-08-16 14:02:36', '201908161402363566947', 'Havana Club');
INSERT INTO `order` VALUES ('257', '23', '13', '14.7', '0.0', '100.00', '1470.00', '2019-08-16 14:02:38', '2019-08-16 14:02:38', '201908161402377570976', 'Havana Club');
INSERT INTO `order` VALUES ('258', '23', '13', '15.7', '0.0', '100.00', '1570.00', '2019-08-16 14:02:39', '2019-08-16 14:02:39', '201908161402390745842', 'Havana Club');
INSERT INTO `order` VALUES ('259', '23', '12', '3', '0.0', '12.00', '36.00', '2019-08-16 14:02:43', '2019-08-16 14:02:43', '201908161402426361902', 'Volvic 50cl');
INSERT INTO `order` VALUES ('260', '23', '12', '4', '0.0', '12.00', '48.00', '2019-08-16 14:02:44', '2019-08-16 14:02:44', '201908161402439234922', 'Volvic 50cl');
INSERT INTO `order` VALUES ('261', '23', '55', '4', '0.0', '86.00', '344.00', '2019-08-16 14:03:24', '2019-08-16 14:03:24', '201908161403235569427', 'Tanqueray');
INSERT INTO `order` VALUES ('262', '23', '55', '5', '0.0', '86.00', '430.00', '2019-08-16 14:03:25', '2019-08-16 14:03:25', '201908161403244829139', 'Tanqueray');
INSERT INTO `order` VALUES ('279', '23', '59', '1', '0.0', '45.00', '45.00', '2019-08-17 14:22:13', '2019-08-17 14:22:13', '201908171422134005191', 'Capi Grapefruit');
INSERT INTO `order` VALUES ('280', '23', '59', '2', '0.0', '45.00', '90.00', '2019-08-17 14:22:15', '2019-08-17 14:22:15', '201908171422144928152', 'Capi Grapefruit');
INSERT INTO `order` VALUES ('281', '23', '59', '3', '0.0', '45.00', '135.00', '2019-08-17 14:27:47', '2019-08-17 14:27:47', '201908171427467595851', 'Capi Grapefruit');
INSERT INTO `order` VALUES ('282', '23', '59', '3', '0.0', '45.00', '135.00', '2019-08-17 14:27:48', '2019-08-17 14:27:48', '201908171427482490199', 'Capi Grapefruit');
INSERT INTO `order` VALUES ('283', '23', '59', '4', '0.0', '45.00', '180.00', '2019-08-17 14:28:01', '2019-08-17 14:28:01', '201908171428011420112', 'Capi Grapefruit');
INSERT INTO `order` VALUES ('284', '23', '59', '4', '0.0', '45.00', '180.00', '2019-08-17 14:28:03', '2019-08-17 14:28:03', '201908171428029906032', 'Capi Grapefruit');
INSERT INTO `order` VALUES ('285', '23', '59', '5', '0.0', '45.00', '225.00', '2019-08-17 14:32:17', '2019-08-17 14:32:17', '201908171432166875954', 'Capi Grapefruit');
INSERT INTO `order` VALUES ('286', '23', '59', '5', '0.0', '45.00', '225.00', '2019-08-17 14:32:18', '2019-08-17 14:32:18', '201908171432177702978', 'Capi Grapefruit');
INSERT INTO `order` VALUES ('288', '23', '59', '6', '0.0', '45.00', '270.00', '2019-08-17 16:23:52', '2019-08-17 16:23:52', '201908171623522320795', 'Capi Grapefruit');
INSERT INTO `order` VALUES ('289', '23', '59', '7', '0.0', '45.00', '315.00', '2019-08-17 16:23:56', '2019-08-17 16:23:56', '201908171623563632622', 'Capi Grapefruit');
INSERT INTO `order` VALUES ('290', '23', '59', '7', '0.0', '45.00', '315.00', '2019-08-17 16:24:00', '2019-08-17 16:24:00', '201908171624000009081', 'Capi Grapefruit');
INSERT INTO `order` VALUES ('292', '23', '56', '1', '0.0', '85.00', '85.00', '2019-08-17 17:22:56', '2019-08-17 17:22:56', '201908171722555341287', 'Cointreau ');
INSERT INTO `order` VALUES ('293', '23', '58', '1', '0.0', '110.00', '110.00', '2019-08-17 17:25:31', '2019-08-17 17:25:31', '201908171725306239562', 'Absolut Vodka');
INSERT INTO `order` VALUES ('294', '23', '58', '1', '0.6', '110.00', '176.00', '2019-08-17 17:25:40', '2019-08-17 17:25:40', '201908171725395091317', 'Absolut Vodka');
INSERT INTO `order` VALUES ('295', '23', '56', '1', '0.0', '85.00', '85.00', '2019-08-17 17:27:56', '2019-08-17 17:27:56', '201908171727555934512', 'Cointreau ');
INSERT INTO `order` VALUES ('296', '23', '58', '2.6', '0.0', '110.00', '286.00', '2019-08-17 17:30:05', '2019-08-17 17:30:05', '201908171730051605566', 'Absolut Vodka');
INSERT INTO `order` VALUES ('297', '23', '58', '2.6', '0.0', '110.00', '286.00', '2019-08-17 17:30:06', '2019-08-17 17:30:06', '201908171730063891351', 'Absolut Vodka');
INSERT INTO `order` VALUES ('298', '23', '58', '3.6', '0.0', '110.00', '396.00', '2019-08-17 17:30:07', '2019-08-17 17:30:07', '201908171730073028805', 'Absolut Vodka');
INSERT INTO `order` VALUES ('299', '23', '58', '4.6', '0.0', '110.00', '506.00', '2019-08-17 17:30:09', '2019-08-17 17:30:09', '201908171730091625264', 'Absolut Vodka');
INSERT INTO `order` VALUES ('300', '23', '58', '6.6', '0.5', '110.00', '781.00', '2019-08-17 17:30:27', '2019-08-17 17:30:27', '201908171730266729503', 'Absolut Vodka');
INSERT INTO `order` VALUES ('301', '23', '58', '6.6', '0.5', '110.00', '781.00', '2019-08-17 17:30:29', '2019-08-17 17:30:29', '201908171730288822892', 'Absolut Vodka');
INSERT INTO `order` VALUES ('302', '23', '55', '6', '0.0', '86.00', '516.00', '2019-08-17 17:30:33', '2019-08-17 17:30:33', '201908171730328701217', 'Tanqueray');
INSERT INTO `order` VALUES ('303', '23', '55', '6', '0.0', '86.00', '516.00', '2019-08-17 17:30:37', '2019-08-17 17:30:37', '201908171730366802952', 'Tanqueray');
INSERT INTO `order` VALUES ('304', '23', '56', '2', '0.0', '85.00', '170.00', '2019-08-17 17:31:52', '2019-08-17 17:31:52', '201908171731520771444', 'Cointreau ');
INSERT INTO `order` VALUES ('305', '23', '56', '3', '0.0', '85.00', '255.00', '2019-08-17 17:31:54', '2019-08-17 17:31:54', '201908171731535953014', 'Cointreau ');
INSERT INTO `order` VALUES ('306', '23', '56', '4', '0.0', '85.00', '340.00', '2019-08-17 17:31:55', '2019-08-17 17:31:55', '201908171731547520976', 'Cointreau ');
INSERT INTO `order` VALUES ('307', '23', '56', '5', '0.0', '85.00', '425.00', '2019-08-17 17:31:56', '2019-08-17 17:31:56', '201908171731557543972', 'Cointreau ');
INSERT INTO `order` VALUES ('308', '23', '56', '6', '0.0', '85.00', '510.00', '2019-08-17 17:31:57', '2019-08-17 17:31:57', '201908171731563169823', 'Cointreau ');
INSERT INTO `order` VALUES ('309', '23', '56', '7', '0.0', '85.00', '595.00', '2019-08-17 17:32:03', '2019-08-17 17:32:03', '201908171732026513216', 'Cointreau ');
INSERT INTO `order` VALUES ('310', '23', '56', '7', '0.0', '85.00', '595.00', '2019-08-17 17:32:04', '2019-08-17 17:32:04', '201908171732043512063', 'Cointreau ');
INSERT INTO `order` VALUES ('311', '23', '56', '8', '0.0', '85.00', '680.00', '2019-08-17 17:32:05', '2019-08-17 17:32:05', '201908171732052436526', 'Cointreau ');
INSERT INTO `order` VALUES ('312', '23', '56', '9', '0.0', '85.00', '765.00', '2019-08-17 17:32:07', '2019-08-17 17:32:07', '201908171732072743834', 'Cointreau ');
INSERT INTO `order` VALUES ('313', '23', '56', '10', '0.0', '85.00', '850.00', '2019-08-17 17:32:09', '2019-08-17 17:32:09', '201908171732089649267', 'Cointreau ');
INSERT INTO `order` VALUES ('314', '23', '56', '11', '0.0', '85.00', '935.00', '2019-08-17 17:32:10', '2019-08-17 17:32:10', '201908171732104992537', 'Cointreau ');
INSERT INTO `order` VALUES ('327', '23', '12', '12', '0.6', '12.00', '151.20', '2019-08-17 17:35:54', '2019-08-17 17:35:54', '201908171735538320527', 'Volvic 50cl');
INSERT INTO `order` VALUES ('328', '23', '13', '15.7', '0.0', '100.00', '1570.00', '2019-08-17 17:36:00', '2019-08-17 17:36:00', '201908171735596688187', 'Havana Club');
INSERT INTO `order` VALUES ('343', '23', '59', '8', '0.0', '45.00', '360.00', '2019-08-17 17:40:54', '2019-08-17 17:40:54', '201908171740533627323', 'Capi Grapefruit');
INSERT INTO `order` VALUES ('344', '23', '59', '9', '0.0', '45.00', '405.00', '2019-08-17 17:40:55', '2019-08-17 17:40:55', '201908171740548929188', 'Capi Grapefruit');
INSERT INTO `order` VALUES ('345', '23', '59', '10', '0.0', '45.00', '450.00', '2019-08-17 17:40:56', '2019-08-17 17:40:56', '201908171740561301115', 'Capi Grapefruit');
INSERT INTO `order` VALUES ('346', '23', '59', '11', '0.0', '45.00', '495.00', '2019-08-17 17:40:57', '2019-08-17 17:40:57', '201908171740570399745', 'Capi Grapefruit');
INSERT INTO `order` VALUES ('347', '23', '59', '12', '0.0', '45.00', '540.00', '2019-08-17 17:40:59', '2019-08-17 17:40:59', '201908171740588847637', 'Capi Grapefruit');
INSERT INTO `order` VALUES ('348', '23', '59', '13', '0.0', '45.00', '585.00', '2019-08-17 17:41:00', '2019-08-17 17:41:00', '201908171740599789221', 'Capi Grapefruit');
INSERT INTO `order` VALUES ('349', '23', '59', '14', '0.0', '45.00', '630.00', '2019-08-17 17:41:01', '2019-08-17 17:41:01', '201908171741011034872', 'Capi Grapefruit');
INSERT INTO `order` VALUES ('350', '23', '59', '15', '0.0', '45.00', '675.00', '2019-08-17 17:41:03', '2019-08-17 17:41:03', '201908171741031878793', 'Capi Grapefruit');
INSERT INTO `order` VALUES ('475', '23', '59', '16', '0.0', '45.00', '720.00', '2019-08-18 15:07:01', '2019-08-18 15:07:01', '201908181507006934893', 'Capi Grapefruit');
INSERT INTO `order` VALUES ('476', '23', '59', '17', '0.0', '45.00', '765.00', '2019-08-18 15:07:02', '2019-08-18 15:07:02', '201908181507022270982', 'Capi Grapefruit');
INSERT INTO `order` VALUES ('477', '23', '59', '18', '0.0', '45.00', '810.00', '2019-08-18 15:07:03', '2019-08-18 15:07:03', '201908181507034646385', 'Capi Grapefruit');
INSERT INTO `order` VALUES ('478', '23', '56', '11', '0.6', '85.00', '986.00', '2019-08-18 15:07:37', '2019-08-18 15:07:37', '201908181507373198097', 'Cointreau ');
INSERT INTO `order` VALUES ('479', '23', '59', '19', '0.0', '45.00', '855.00', '2019-08-18 15:22:31', '2019-08-18 15:22:31', '201908181522309945302', 'Capi Grapefruit');
INSERT INTO `order` VALUES ('480', '23', '59', '19', '0.0', '45.00', '855.00', '2019-08-18 15:22:33', '2019-08-18 15:22:33', '201908181522325289042', 'Capi Grapefruit');
INSERT INTO `order` VALUES ('481', '23', '60', '3', '0.4', '250.00', '850.00', '2019-08-18 19:47:58', '2019-08-18 19:47:58', '201908181947588007787', 'Bulleit Rye');
INSERT INTO `order` VALUES ('482', '23', '59', '19', '0.6', '45.00', '882.00', '2019-08-18 19:48:09', '2019-08-18 19:48:09', '201908181948087585955', 'Capi Grapefruit');
INSERT INTO `order` VALUES ('483', '23', '59', '19', '0.6', '45.00', '882.00', '2019-08-18 19:48:18', '2019-08-18 19:48:18', '201908181948182740774', 'Capi Grapefruit');
INSERT INTO `order` VALUES ('484', '23', '60', '4.4', '0.0', '250.00', '1100.00', '2019-08-18 23:56:46', '2019-08-18 23:56:46', '201908182356459942224', 'Bulleit Rye');
INSERT INTO `order` VALUES ('485', '23', '60', '5.4', '0.0', '250.00', '1350.00', '2019-08-18 23:56:47', '2019-08-18 23:56:47', '201908182356477251431', 'Bulleit Rye');
INSERT INTO `order` VALUES ('486', '23', '60', '6.4', '0.0', '250.00', '1600.00', '2019-08-18 23:56:49', '2019-08-18 23:56:49', '201908182356493644013', 'Bulleit Rye');
INSERT INTO `order` VALUES ('487', '23', '60', '7.4', '0.0', '250.00', '1850.00', '2019-08-18 23:56:51', '2019-08-18 23:56:51', '201908182356508168197', 'Bulleit Rye');
INSERT INTO `order` VALUES ('488', '23', '60', '8.4', '0.0', '250.00', '2100.00', '2019-08-18 23:56:52', '2019-08-18 23:56:52', '201908182356511726995', 'Bulleit Rye');
INSERT INTO `order` VALUES ('489', '23', '60', '9.4', '0.0', '250.00', '2350.00', '2019-08-18 23:56:54', '2019-08-18 23:56:54', '201908182356544494599', 'Bulleit Rye');
INSERT INTO `order` VALUES ('490', '23', '59', '20.6', '0.0', '45.00', '927.00', '2019-08-18 23:56:56', '2019-08-18 23:56:56', '201908182356559971569', 'Capi Grapefruit');
INSERT INTO `order` VALUES ('491', '23', '59', '21.6', '0.0', '45.00', '972.00', '2019-08-18 23:56:57', '2019-08-18 23:56:57', '201908182356571071625', 'Capi Grapefruit');
INSERT INTO `order` VALUES ('492', '23', '58', '8.1', '0.0', '110.00', '891.00', '2019-08-18 23:56:58', '2019-08-18 23:56:58', '201908182356583957424', 'Absolut Vodka');
INSERT INTO `order` VALUES ('493', '23', '58', '10.1', '0.6', '110.00', '1177.00', '2019-08-18 23:57:10', '2019-08-18 23:57:10', '201908182357101736577', 'Absolut Vodka');
INSERT INTO `order` VALUES ('494', '23', '58', '10.1', '0.6', '110.00', '1177.00', '2019-08-18 23:57:12', '2019-08-18 23:57:12', '201908182357113150318', 'Absolut Vodka');
INSERT INTO `order` VALUES ('495', '23', '76', '1', '0.0', '345.00', '345.00', '2019-08-19 00:04:31', '2019-08-19 00:04:31', '201908190004313078535', 'Panna Water');
INSERT INTO `order` VALUES ('496', '23', '76', '2', '0.0', '345.00', '690.00', '2019-08-19 00:04:33', '2019-08-19 00:04:33', '201908190004331551735', 'Panna Water');
INSERT INTO `order` VALUES ('497', '23', '75', '12', '0.0', '349.00', '4188.00', '2019-08-19 00:05:35', '2019-08-19 00:05:35', '201908190005349178414', 'Aberlour 10Y');
INSERT INTO `order` VALUES ('498', '23', '71', '15', '0.0', '340.00', '5100.00', '2019-08-19 00:05:56', '2019-08-19 00:05:56', '201908190005555685272', 'Tanqueray 10');
INSERT INTO `order` VALUES ('518', '23', '76', '65', '0.0', '345.00', '22425.00', '2019-08-19 15:37:23', '2019-08-19 15:37:23', '201908191537233468482', 'Panna Water');
INSERT INTO `order` VALUES ('519', '23', '75', '50', '0.0', '349.00', '17450.00', '2019-08-19 15:37:30', '2019-08-19 15:37:30', '201908191537303882368', 'Aberlour 10Y');
INSERT INTO `order` VALUES ('520', '23', '74', '658', '0.0', '259.00', '170422.00', '2019-08-19 15:37:33', '2019-08-19 15:37:33', '201908191537325316994', 'Singleton 12Y');
INSERT INTO `order` VALUES ('521', '23', '73', '688', '0.0', '300.00', '206400.00', '2019-08-19 15:37:38', '2019-08-19 15:37:38', '201908191537377567785', 'Talisker 10Y');
INSERT INTO `order` VALUES ('522', '23', '72', '965', '0.0', '123.00', '118695.00', '2019-08-19 15:37:45', '2019-08-19 15:37:45', '201908191537444818512', 'Tamdhu 10Y');
INSERT INTO `order` VALUES ('523', '23', '71', '15', '0.3', '340.00', '5202.00', '2019-08-19 15:42:15', '2019-08-19 15:42:15', '201908191542151029966', 'Tanqueray 10');
INSERT INTO `order` VALUES ('524', '23', '76', '850', '0.6', '345.00', '293457.00', '2019-08-19 15:42:38', '2019-08-19 15:42:38', '201908191542377894183', 'Panna Water');
INSERT INTO `order` VALUES ('525', '24', '69', '1', '0.0', '460.00', '460.00', '2019-08-19 16:06:14', '2019-08-19 16:06:14', '201908191606144000985', 'Macallan 12');
INSERT INTO `order` VALUES ('526', '24', '71', '23', '0.0', '340.00', '7820.00', '2019-08-19 16:17:18', '2019-08-19 16:17:18', '201908191617177182832', 'Tanqueray 10');
INSERT INTO `order` VALUES ('527', '24', '72', '1', '0.3', '123.00', '159.90', '2019-08-19 16:20:41', '2019-08-19 16:20:41', '201908191620413406336', 'Tamdhu 10Y');
INSERT INTO `order` VALUES ('528', '24', '79', '1', '0.0', '350.00', '350.00', '2019-08-19 16:23:43', '2019-08-19 16:23:43', '201908191623433265635', 'London no 1');
INSERT INTO `order` VALUES ('529', '24', '79', '2', '0.0', '350.00', '700.00', '2019-08-19 16:23:46', '2019-08-19 16:23:46', '201908191623458974545', 'London no 1');
INSERT INTO `order` VALUES ('530', '24', '79', '3', '0.0', '350.00', '1050.00', '2019-08-19 16:23:48', '2019-08-19 16:23:48', '201908191623481198468', 'London no 1');
INSERT INTO `order` VALUES ('531', '24', '79', '4', '0.0', '350.00', '1400.00', '2019-08-19 16:23:48', '2019-08-19 16:23:48', '201908191623482834697', 'London no 1');
INSERT INTO `order` VALUES ('532', '24', '79', '3', '0.0', '350.00', '1050.00', '2019-08-19 16:23:49', '2019-08-19 16:23:49', '201908191623491935225', 'London no 1');
INSERT INTO `order` VALUES ('533', '24', '79', '2', '0.0', '350.00', '700.00', '2019-08-19 16:23:51', '2019-08-19 16:23:51', '201908191623507168694', 'London no 1');
INSERT INTO `order` VALUES ('534', '24', '79', '1', '0.0', '350.00', '350.00', '2019-08-19 16:23:52', '2019-08-19 16:23:52', '201908191623517264407', 'London no 1');
INSERT INTO `order` VALUES ('535', '24', '71', '1', '0.0', '340.00', '340.00', '2019-08-19 16:25:12', '2019-08-19 16:25:12', '201908191625121831815', 'Tanqueray 10');
INSERT INTO `order` VALUES ('536', '24', '71', '12', '0.0', '340.00', '4080.00', '2019-08-19 16:25:26', '2019-08-19 16:25:26', '201908191625257749534', 'Tanqueray 10');
INSERT INTO `order` VALUES ('537', '24', '71', '1', '0.0', '340.00', '340.00', '2019-08-19 16:25:38', '2019-08-19 16:25:38', '201908191625377956676', 'Tanqueray 10');
INSERT INTO `order` VALUES ('538', '24', '71', '2', '0.0', '340.00', '680.00', '2019-08-19 16:25:51', '2019-08-19 16:25:51', '201908191625510691445', 'Tanqueray 10');
INSERT INTO `order` VALUES ('539', '24', '81', '24', '0.0', '568.00', '13632.00', '2019-08-19 16:26:22', '2019-08-19 16:26:22', '201908191626220468855', 'Lagavulin 16');
INSERT INTO `order` VALUES ('540', '24', '81', '1', '0.0', '568.00', '568.00', '2019-08-19 16:26:26', '2019-08-19 16:26:26', '201908191626264627926', 'Lagavulin 16');
INSERT INTO `order` VALUES ('541', '24', '72', '1.3', '0.0', '123.00', '159.90', '2019-08-19 16:26:31', '2019-08-19 16:26:31', '201908191626309508264', 'Tamdhu 10Y');
INSERT INTO `order` VALUES ('542', '24', '63', '4', '0.0', '754.00', '3016.00', '2019-08-19 16:27:08', '2019-08-19 16:27:08', '201908191627076484954', 'Yamazaki 12');
INSERT INTO `order` VALUES ('543', '24', '63', '1', '0.0', '754.00', '754.00', '2019-08-19 18:10:31', '2019-08-19 18:10:31', '201908191810313943353', 'Yamazaki 12');
INSERT INTO `order` VALUES ('544', '24', '71', '1', '0.0', '340.00', '340.00', '2019-08-19 18:10:41', '2019-08-19 18:10:41', '201908191810410343025', 'Tanqueray 10');
INSERT INTO `order` VALUES ('545', '24', '72', '0.3', '0.0', '123.00', '36.90', '2019-08-19 18:10:42', '2019-08-19 18:10:42', '201908191810424958248', 'Tamdhu 10Y');
INSERT INTO `order` VALUES ('546', '24', '63', '1', '0.6', '754.00', '1206.40', '2019-08-20 12:33:43', '2019-08-20 12:33:43', '201908201233428623502', 'Yamazaki 12');
INSERT INTO `order` VALUES ('547', '23', '61', '0', '0.8', '300.00', '240.00', '2019-08-30 14:49:07', '2019-08-30 14:49:07', '201908301449072293453', 'Bulleit Bourbon');
INSERT INTO `order` VALUES ('548', '23', '61', '2', '0.8', '300.00', '840.00', '2019-08-30 14:49:12', '2019-08-30 14:49:12', '201908301449117123291', 'Bulleit Bourbon');
INSERT INTO `order` VALUES ('549', '23', '80', '1', '0.0', '450.00', '450.00', '2019-08-31 04:42:36', '2019-08-31 04:42:36', '201908310442362038865', 'Le Tribute Gin');
INSERT INTO `order` VALUES ('550', '23', '77', '1', '0.0', '345.00', '345.00', '2019-08-31 04:42:38', '2019-08-31 04:42:38', '201908310442382051914', 'Oban 14');
INSERT INTO `order` VALUES ('551', '23', '76', '851.6', '0.0', '345.00', '293802.00', '2019-08-31 04:42:40', '2019-08-31 04:42:40', '201908310442397131546', 'Panna Water');
INSERT INTO `order` VALUES ('552', '23', '76', '800', '0.6', '345.00', '276207.00', '2019-08-31 04:43:12', '2019-08-31 04:43:12', '201908310443115100558', 'Panna Water');
INSERT INTO `order` VALUES ('553', '23', '80', '2', '0.0', '450.00', '900.00', '2019-09-03 05:54:54', '2019-09-03 05:54:54', '201909030554537474036', 'Le Tribute Gin');
INSERT INTO `order` VALUES ('554', '23', '80', '3', '0.0', '450.00', '1350.00', '2019-09-03 05:54:56', '2019-09-03 05:54:56', '201909030554555469356', 'Le Tribute Gin');
INSERT INTO `order` VALUES ('555', '23', '79', '1', '0.0', '350.00', '350.00', '2019-09-03 05:54:57', '2019-09-03 05:54:57', '201909030554568251295', 'London no 1');
INSERT INTO `order` VALUES ('556', '23', '79', '6', '0.0', '350.00', '2100.00', '2019-09-03 05:55:01', '2019-09-03 05:55:01', '201909030555005221913', 'London no 1');
INSERT INTO `order` VALUES ('557', '23', '64', '6', '0.0', '250.00', '1500.00', '2019-09-03 05:55:12', '2019-09-03 05:55:12', '201909030555124317713', 'Cragganmore 12');
INSERT INTO `order` VALUES ('558', '24', '80', '1', '0.0', '450.00', '450.00', '2019-09-03 11:34:57', '2019-09-03 11:34:57', '201909031134574083822', 'Le Tribute Gin');
INSERT INTO `order` VALUES ('559', '24', '70', '1', '0.0', '235.00', '235.00', '2019-09-03 11:35:07', '2019-09-03 11:35:07', '201909031135077295555', 'Teeling Whiskey');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `uid` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户uid',
  `nickname` varchar(100) NOT NULL DEFAULT '' COMMENT '用户名',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '手机号码',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '邮箱地址',
  `sex` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1：男 2：女 0：没填写',
  `avatar` varchar(64) NOT NULL DEFAULT '' COMMENT '头像',
  `login_name` varchar(20) NOT NULL DEFAULT '' COMMENT '登录用户名',
  `login_pwd` varchar(32) NOT NULL DEFAULT '' COMMENT '登录密码',
  `login_salt` varchar(32) NOT NULL DEFAULT '' COMMENT '登录密码的随机加密秘钥',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1：有效 0：无效',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:货物管理 1:发票管理\r\n',
  `updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次更新时间',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '插入时间',
  `role` varchar(255) DEFAULT NULL COMMENT '角色',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `login_name` (`login_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='用户表（管理员）';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '管理员', '11012345679', 'admin@163.com', '1', '', 'admin', '816440c40b7a9d55ff9eb7b20760862c', 'cF3JfH5FJfQ8B2Ba', '1', '0', '2019-08-12 02:04:15', '2019-08-11 14:08:48', null);
INSERT INTO `user` VALUES ('2', 'sami', '18811112222', 'sami@163.com', '1', '', 'sami', 'cf8119383aa4d38beb6891b5ae05f363', 'USiTx0cvR0f5sySN', '1', '0', '2019-08-12 20:24:42', '2019-08-12 20:24:42', 'admin');
