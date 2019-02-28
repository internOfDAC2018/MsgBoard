/*
 Navicat Premium Data Transfer

 Source Server         : lyu
 Source Server Type    : MySQL
 Source Server Version : 50723
 Source Host           : localhost:3306
 Source Schema         : msgboard

 Target Server Type    : MySQL
 Target Server Version : 50723
 File Encoding         : 65001

 Date: 28/02/2019 13:40:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for mb_msg
-- ----------------------------
DROP TABLE IF EXISTS `mb_msg`;
CREATE TABLE `mb_msg`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userid` bigint(20) NOT NULL,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `date` datetime(0) NULL DEFAULT NULL,
  `pic` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'URL+默认图片',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `userid`(`userid`) USING BTREE,
  CONSTRAINT `mb_msg_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `mb_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mb_msg
-- ----------------------------
INSERT INTO `mb_msg` VALUES (1, 1, '我是信息1', '2019-02-26 16:14:15', '');
INSERT INTO `mb_msg` VALUES (2, 1, '我是信息2', '2019-02-20 16:36:31', 'default.jpg');
INSERT INTO `mb_msg` VALUES (3, 2, '我是信息3', '2019-02-06 09:38:03', 'Xx.jpg');
INSERT INTO `mb_msg` VALUES (4, 2, 'happy studay 4', '2019-02-20 09:42:28', '4.jpg');
INSERT INTO `mb_msg` VALUES (5, 3, '这是第五条 5', '2019-02-06 09:43:06', '8.jpg');
INSERT INTO `mb_msg` VALUES (6, 9, 'darker 6', '2019-02-13 09:43:35', '9.jpg');
INSERT INTO `mb_msg` VALUES (7, 9, 'what 7', '2019-01-31 09:44:08', '8.jpg');
INSERT INTO `mb_msg` VALUES (8, 5, 'speed 8', '2019-02-22 09:44:30', '8.jpg');
INSERT INTO `mb_msg` VALUES (9, 5, 'feel 9', '2019-02-27 09:45:03', '9.jpg');
INSERT INTO `mb_msg` VALUES (10, 6, 'ahoduoa 10', '2019-01-30 09:45:22', '10.jpg');
INSERT INTO `mb_msg` VALUES (11, 7, 'daoshu 11', '2019-03-01 09:45:46', 'sad.jpg');
INSERT INTO `mb_msg` VALUES (12, 8, 'zuihou 12', '2019-02-13 09:46:13', 'shui.jpg');
INSERT INTO `mb_msg` VALUES (13, 7, '测试分页 13', '2019-02-28 09:46:42', 'ad.jpg');
INSERT INTO `mb_msg` VALUES (14, 2, 'as the city burns.', NULL, 'ce552229cccb472cb3e6004203c2f780.jpg');
INSERT INTO `mb_msg` VALUES (15, 2, 'as the city burns.', '2019-02-28 02:49:56', 'ce552229cccb472cb3e6004203c2f780.jpg');
INSERT INTO `mb_msg` VALUES (16, 2, 'as the city burns.', '2019-02-28 05:35:03', 'ce552229cccb472cb3e6004203c2f780.jpg');

-- ----------------------------
-- Table structure for mb_user
-- ----------------------------
DROP TABLE IF EXISTS `mb_user`;
CREATE TABLE `mb_user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `login_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登录名+不能重复，注册的时候要校验 只用于登陆',
  `username` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称 数据安全 其他时候显示',
  `password` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '需要加密',
  `description` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `profile_pic` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'default.jpg',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mb_user
-- ----------------------------
INSERT INTO `mb_user` VALUES (1, 'nwww', 'hui', 'MTIz', '我爱吃包子', 'default.jpg');
INSERT INTO `mb_user` VALUES (2, 'hooo', 'hoo', 'MTIz', 'loy', 'ce552229cccb472cb3e6004203c2f780.jpg');
INSERT INTO `mb_user` VALUES (3, 'hui', 'haoo', 'MTIz', NULL, 'default.jpg');
INSERT INTO `mb_user` VALUES (4, '3333', '2222', 'NjY2NjY=', NULL, 'default.jpg');
INSERT INTO `mb_user` VALUES (5, '12345', 'wer', 'MjIy', NULL, 'default.jpg');
INSERT INTO `mb_user` VALUES (6, '34556', 'druidx', 'd3d3', NULL, 'default.jpg');
INSERT INTO `mb_user` VALUES (7, '12345', '23456', 'MTIz', NULL, 'default.jpg');
INSERT INTO `mb_user` VALUES (8, 'Hjghh', 'ghhj', 'MTIz', NULL, 'default.jpg');
INSERT INTO `mb_user` VALUES (9, 'lvyuyu', 'luna', 'MTIz', 'I love puppies.', 'default.jpg');
INSERT INTO `mb_user` VALUES (10, 'Wuyiheng', 'wuyiheng', 'MTIzNDU2', NULL, 'default.jpg');
INSERT INTO `mb_user` VALUES (11, '', '', '', '1', 'default.jpg');
INSERT INTO `mb_user` VALUES (12, '1', 'jiu', 'MTIz', NULL, 'default.jpg');

SET FOREIGN_KEY_CHECKS = 1;
