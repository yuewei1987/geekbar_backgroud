/*
 Navicat Premium Data Transfer

 Source Server         : aliyun
 Source Server Type    : MySQL
 Source Server Version : 50643
 Source Schema         : geekbar

 Target Server Type    : MySQL
 Target Server Version : 50643
 File Encoding         : 65001

 Date: 12/08/2019 21:36:15
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
) ENGINE=InnoDB AUTO_INCREMENT=809 DEFAULT CHARSET=utf8mb4 COMMENT='用户访问记录表';

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
BEGIN;
INSERT INTO `banner` VALUES (1, 'img', '20190812/37d131c9fd03461bbfe7e384eddf898a.jpeg', 'http://www.baidu.com', '2019-07-28 22:17:24', '2019-07-28 22:17:29', '0');
INSERT INTO `banner` VALUES (2, 'img', '20190812/d80df82b261e4c13af4d5d7d5d78066f.jpeg', NULL, '2019-07-28 22:18:17', '2019-07-28 22:18:22', '0');
COMMIT;

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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of goods
-- ----------------------------
BEGIN;
INSERT INTO `goods` VALUES (12, '3057640117008', '20190801/c34a5cc19da64f1c8f54adc0ae5a8eb6.png', 'Volvic 50cl', '', '2019-08-01 20:34:07', '2019-08-01 20:34:07', '0', '0', '0', '12.00', 0);
INSERT INTO `goods` VALUES (13, '6901028118170', '20190801/954ccbb3772a48cb9499e7ad1987a6b6.jpeg', 'Havana Club', '', '2019-08-01 22:03:58', '2019-08-01 22:03:58', '0', '0', '0', '100.00', 0);
INSERT INTO `goods` VALUES (14, '3012992421005', '20190803/8099a3526fc64c8e9495a7bd2d9fa279.png', 'Sir Edward\'s Scotch', '', '2019-08-03 22:19:45', '2019-08-03 22:19:45', '0', '0', '0', '120.00', 0);
COMMIT;

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
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COMMENT='发票表';

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COMMENT='评价表';
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
) ENGINE=InnoDB AUTO_INCREMENT=419 DEFAULT CHARSET=utf8mb4 COMMENT='评价图片表';


-- ----------------------------
-- Table structure for images
-- ----------------------------
DROP TABLE IF EXISTS `images`;
CREATE TABLE `images` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `file_key` varchar(60) NOT NULL DEFAULT '' COMMENT '文件名',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '插入时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of images
-- ----------------------------
BEGIN;
INSERT INTO `images` VALUES (33, '20190812/37d131c9fd03461bbfe7e384eddf898a.jpeg', '2019-08-12 21:29:15');
INSERT INTO `images` VALUES (34, '20190812/d80df82b261e4c13af4d5d7d5d78066f.jpeg', '2019-08-12 21:29:20');
COMMIT;

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
  `group_name` varchar(255) DEFAULT NULL COMMENT '分组名',
  `updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次更新时间',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '插入时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COMMENT='会员表';


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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COMMENT='第三方登录绑定关系';

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
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `uid` bigint(20) NOT NULL AUTO_INCREMENT COMMENT ''用户uid'',
  `nickname` varchar(100) NOT NULL DEFAULT '''' COMMENT ''用户名'',
  `mobile` varchar(20) NOT NULL DEFAULT '''' COMMENT ''手机号码'',
  `email` varchar(100) NOT NULL DEFAULT '''' COMMENT ''邮箱地址'',
  `sex` tinyint(1) NOT NULL DEFAULT ''0'' COMMENT ''1：男 2：女 0：没填写'',
  `avatar` varchar(64) NOT NULL DEFAULT '''' COMMENT ''头像'',
  `login_name` varchar(20) NOT NULL DEFAULT '''' COMMENT ''登录用户名'',
  `login_pwd` varchar(32) NOT NULL DEFAULT '''' COMMENT ''登录密码'',
  `login_salt` varchar(32) NOT NULL DEFAULT '''' COMMENT ''登录密码的随机加密秘钥'',
  `role` varchar(255) DEFAULT NULL COMMENT ''角色'',
  `status` tinyint(1) NOT NULL DEFAULT ''1'' COMMENT ''1：有效 0：无效'',
  `type` tinyint(1) NOT NULL DEFAULT ''0'' COMMENT ''0:货物管理 1:发票管理'',
  `updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT ''最后一次更新时间'',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT ''插入时间'',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `login_name` (`login_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT=''用户表（管理员）'';

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES (1, '管理员', '11012345679', 'admin@163.com', 1, '', 'admin', '816440c40b7a9d55ff9eb7b20760862c', 'cF3JfH5FJfQ8B2Ba', 1, '2019-08-12 02:04:15', '2019-08-11 14:08:48');
INSERT INTO `user` VALUES (2, 'sami', '18811112222', 'sami@163.com', 1, '', 'sami', 'cf8119383aa4d38beb6891b5ae05f363', 'USiTx0cvR0f5sySN', 1, '2019-08-12 20:24:42', '2019-08-12 20:24:42');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
