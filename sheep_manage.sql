/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 80026
 Source Host           : localhost:3306
 Source Schema         : sheep_manage

 Target Server Type    : MySQL
 Target Server Version : 80026
 File Encoding         : 65001

 Date: 27/06/2025 18:31:47
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add permission', 1, 'add_permission');
INSERT INTO `auth_permission` VALUES (2, 'Can change permission', 1, 'change_permission');
INSERT INTO `auth_permission` VALUES (3, 'Can delete permission', 1, 'delete_permission');
INSERT INTO `auth_permission` VALUES (4, 'Can view permission', 1, 'view_permission');
INSERT INTO `auth_permission` VALUES (5, 'Can add group', 2, 'add_group');
INSERT INTO `auth_permission` VALUES (6, 'Can change group', 2, 'change_group');
INSERT INTO `auth_permission` VALUES (7, 'Can delete group', 2, 'delete_group');
INSERT INTO `auth_permission` VALUES (8, 'Can view group', 2, 'view_group');
INSERT INTO `auth_permission` VALUES (9, 'Can add user', 3, 'add_user');
INSERT INTO `auth_permission` VALUES (10, 'Can change user', 3, 'change_user');
INSERT INTO `auth_permission` VALUES (11, 'Can delete user', 3, 'delete_user');
INSERT INTO `auth_permission` VALUES (12, 'Can view user', 3, 'view_user');
INSERT INTO `auth_permission` VALUES (13, 'Can add content type', 4, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (14, 'Can change content type', 4, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (15, 'Can delete content type', 4, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (16, 'Can view content type', 4, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (17, 'Can add session', 5, 'add_session');
INSERT INTO `auth_permission` VALUES (18, 'Can change session', 5, 'change_session');
INSERT INTO `auth_permission` VALUES (19, 'Can delete session', 5, 'delete_session');
INSERT INTO `auth_permission` VALUES (20, 'Can view session', 5, 'view_session');
INSERT INTO `auth_permission` VALUES (21, 'Can add sys user', 6, 'add_sysuser');
INSERT INTO `auth_permission` VALUES (22, 'Can change sys user', 6, 'change_sysuser');
INSERT INTO `auth_permission` VALUES (23, 'Can delete sys user', 6, 'delete_sysuser');
INSERT INTO `auth_permission` VALUES (24, 'Can view sys user', 6, 'view_sysuser');
INSERT INTO `auth_permission` VALUES (25, 'Can add sheep category', 7, 'add_sheepcategory');
INSERT INTO `auth_permission` VALUES (26, 'Can change sheep category', 7, 'change_sheepcategory');
INSERT INTO `auth_permission` VALUES (27, 'Can delete sheep category', 7, 'delete_sheepcategory');
INSERT INTO `auth_permission` VALUES (28, 'Can view sheep category', 7, 'view_sheepcategory');
INSERT INTO `auth_permission` VALUES (29, 'Can add sheep', 8, 'add_sheep');
INSERT INTO `auth_permission` VALUES (30, 'Can change sheep', 8, 'change_sheep');
INSERT INTO `auth_permission` VALUES (31, 'Can delete sheep', 8, 'delete_sheep');
INSERT INTO `auth_permission` VALUES (32, 'Can view sheep', 8, 'view_sheep');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `first_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq`(`user_id`, `group_id`) USING BTREE,
  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id`(`group_id`) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq`(`user_id`, `permission_id`) USING BTREE,
  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (2, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (1, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (4, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (5, 'sessions', 'session');
INSERT INTO `django_content_type` VALUES (8, 'user', 'sheep');
INSERT INTO `django_content_type` VALUES (7, 'user', 'sheepcategory');
INSERT INTO `django_content_type` VALUES (6, 'user', 'sysuser');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'user', '0001_initial', '2025-01-18 07:12:12.218441');
INSERT INTO `django_migrations` VALUES (2, 'contenttypes', '0001_initial', '2025-02-03 08:20:02.552276');
INSERT INTO `django_migrations` VALUES (3, 'contenttypes', '0002_remove_content_type_name', '2025-02-03 08:20:02.624328');
INSERT INTO `django_migrations` VALUES (4, 'auth', '0001_initial', '2025-02-03 08:20:03.068761');
INSERT INTO `django_migrations` VALUES (5, 'auth', '0002_alter_permission_name_max_length', '2025-02-03 08:20:03.117417');
INSERT INTO `django_migrations` VALUES (6, 'auth', '0003_alter_user_email_max_length', '2025-02-03 08:20:03.139033');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0004_alter_user_username_opts', '2025-02-03 08:20:03.144034');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0005_alter_user_last_login_null', '2025-02-03 08:20:03.185170');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0006_require_contenttypes_0002', '2025-02-03 08:20:03.186621');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0007_alter_validators_add_error_messages', '2025-02-03 08:20:03.191628');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0008_alter_user_username_max_length', '2025-02-03 08:20:03.244222');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0009_alter_user_last_name_max_length', '2025-02-03 08:20:03.289214');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0010_alter_group_name_max_length', '2025-02-03 08:20:03.306221');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0011_update_proxy_permissions', '2025-02-03 08:20:03.312234');
INSERT INTO `django_migrations` VALUES (15, 'auth', '0012_alter_user_first_name_max_length', '2025-02-03 08:20:03.360461');
INSERT INTO `django_migrations` VALUES (16, 'sessions', '0001_initial', '2025-02-03 08:20:03.394374');
INSERT INTO `django_migrations` VALUES (17, 'user', '0002_sheepcategory', '2025-02-03 08:20:03.413439');
INSERT INTO `django_migrations` VALUES (18, 'user', '0003_remove_sheepcategory_sheep_category_image', '2025-02-08 13:45:51.467505');
INSERT INTO `django_migrations` VALUES (19, 'user', '0004_sysuser_avatar', '2025-02-10 13:51:02.060135');
INSERT INTO `django_migrations` VALUES (20, 'user', '0005_sheep', '2025-02-12 02:56:51.070146');
INSERT INTO `django_migrations` VALUES (21, 'user', '0006_alter_sheep_table', '2025-02-12 02:56:51.086150');
INSERT INTO `django_migrations` VALUES (22, 'user', '0007_rename_horse_type_sheep_sheep_type', '2025-02-12 02:58:11.527949');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------

-- ----------------------------
-- Table structure for sheep
-- ----------------------------
DROP TABLE IF EXISTS `sheep`;
CREATE TABLE `sheep`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `sheep_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sheep_sex` smallint NOT NULL,
  `sheep_age` int NOT NULL,
  `health_condition` smallint NOT NULL,
  `sheep_type_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sheep_sheep_type_id_d8f5b7c7_fk_sheep_category_id`(`sheep_type_id`) USING BTREE,
  CONSTRAINT `sheep_sheep_type_id_d8f5b7c7_fk_sheep_category_id` FOREIGN KEY (`sheep_type_id`) REFERENCES `sheep_category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 78 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sheep
-- ----------------------------
INSERT INTO `sheep` VALUES (21, '939acf0fd0e0430ebcf1217e51eeedf4', 1, 2, 1, 2);
INSERT INTO `sheep` VALUES (22, '7356cbfe95d1413eaa554d4e191836ae', 1, 0, 1, 1);
INSERT INTO `sheep` VALUES (23, '8cb516d12f004af48f9f7956fe2e45ac', 2, 2, 2, 3);
INSERT INTO `sheep` VALUES (24, '16ccfebe631a41a88be911a6445c1346', 2, 2, 3, 4);
INSERT INTO `sheep` VALUES (25, '23efa2f26d164b37bcba8b97257e4c5f', 1, 4, 1, 5);
INSERT INTO `sheep` VALUES (26, 'f95104e4b61a4c7daf57ed8f95028961', 2, 4, 2, 6);
INSERT INTO `sheep` VALUES (27, '1fb16d49d5a64fd4aa169d0d91aa8af7', 1, 1, 1, 1);
INSERT INTO `sheep` VALUES (28, '7d1d9072bc1c4b17883d53432351d9dd', 1, 1, 1, 6);
INSERT INTO `sheep` VALUES (29, '830c1f8de4e5406fb901a227f09219ba', 1, 3, 4, 7);
INSERT INTO `sheep` VALUES (30, 'c5f95184926a4d59b6bbb6eda26d7b1c', 2, 3, 2, 4);
INSERT INTO `sheep` VALUES (31, 'b00b14e7903849169c4a3fcdfea70507', 2, 2, 2, 1);
INSERT INTO `sheep` VALUES (32, 'ebde5a7cbfba460fb4c4f5dc89ac428e', 2, 1, 1, 9);
INSERT INTO `sheep` VALUES (33, 'c367dce7449946b78aa7a411bc9f0dd7', 1, 1, 2, 5);
INSERT INTO `sheep` VALUES (34, 'b0e7590503f14c239cd343a780192b84', 2, 1, 2, 8);
INSERT INTO `sheep` VALUES (35, '3989bd34aecd43e082872041b819ee33', 1, 1, 2, 9);
INSERT INTO `sheep` VALUES (36, '5141d850f2554981b7cf3110bbbe42eb', 1, 3, 1, 27);
INSERT INTO `sheep` VALUES (37, '026bd93737c249b284636ee591d76a54', 1, 4, 2, 28);
INSERT INTO `sheep` VALUES (38, 'cde44b1f44d443cab72682a547708fd8', 1, 3, 1, 10);
INSERT INTO `sheep` VALUES (39, '4ed73a87d3dd45d8a5f2d24fe4361839', 1, 1, 1, 7);
INSERT INTO `sheep` VALUES (40, 'e4e58e144d0244d6970740f5259c6cc5', 2, 3, 2, 7);
INSERT INTO `sheep` VALUES (41, '65c89b64ee464aa78d070b6d7ee74f10', 1, 7, 2, 10);
INSERT INTO `sheep` VALUES (42, '9655bfbc53e04f95b63d77656d8f79a0', 1, 1, 3, 8);
INSERT INTO `sheep` VALUES (43, '49e152dac46541ab87f71939aa12fb4a', 1, 5, 2, 28);
INSERT INTO `sheep` VALUES (44, '307bc77c07f64fb382e23940833785f5', 1, 3, 1, 10);
INSERT INTO `sheep` VALUES (45, '1a5b0e80b49b46119cfe2c34089e8b5f', 1, 1, 2, 9);
INSERT INTO `sheep` VALUES (46, '05e1d95463c346e78fd76113c2ec9241', 1, 3, 1, 8);
INSERT INTO `sheep` VALUES (47, '130ac78762ac4bf0908109759767ec9e', 1, 1, 1, 27);
INSERT INTO `sheep` VALUES (48, '930772348b4a4a29a69b39ea970cdd0c', 2, 3, 1, 27);
INSERT INTO `sheep` VALUES (49, 'a2998be92c8d4c5e9b70fdc5529df1aa', 1, 2, 1, 4);
INSERT INTO `sheep` VALUES (50, 'e54d94f41e774a7683a12d36e84acec5', 1, 3, 4, 6);
INSERT INTO `sheep` VALUES (51, '65c07adbae7a444386801b2f9c29b1e9', 1, 1, 1, 5);
INSERT INTO `sheep` VALUES (52, 'd2e352b7c00542efb552a01f817b4f50', 1, 1, 1, 1);
INSERT INTO `sheep` VALUES (53, 'ad4241b39ab6454e8b87366eda8434f6', 2, 1, 1, 3);
INSERT INTO `sheep` VALUES (54, '24275b31bafd4eed85c74af198b3f147', 2, 1, 1, 8);
INSERT INTO `sheep` VALUES (55, '2cf21f0505424ef0805f27a897ac936d', 2, 1, 1, 29);
INSERT INTO `sheep` VALUES (56, 'dadff1e201c848b0bdf2d070e2e7d5a8', 2, 3, 2, 27);
INSERT INTO `sheep` VALUES (57, '407d9b3b9a3249b7ba418678fd992d35', 1, 2, 1, 28);
INSERT INTO `sheep` VALUES (58, 'd3aa3aafba0c474c8ae321b8f30030e6', 1, 2, 1, 29);
INSERT INTO `sheep` VALUES (59, 'a4b216652b10404ea6433f58b00cb1e2', 1, 2, 2, 8);
INSERT INTO `sheep` VALUES (60, '5856bd21436b4c7887d5014dc7f97449', 2, 3, 1, 9);
INSERT INTO `sheep` VALUES (61, '5cf67493dd0d43dca4f55c8af74a54e0', 2, 2, 1, 3);
INSERT INTO `sheep` VALUES (62, 'b03cdcabcfe2457485c142b3016bb8c6', 2, 3, 1, 7);
INSERT INTO `sheep` VALUES (63, '35287b07c2fb455f9101229119910ac2', 1, 2, 1, 1);
INSERT INTO `sheep` VALUES (64, '8f03124e84284b328f4c0ea120899705', 2, 2, 1, 2);
INSERT INTO `sheep` VALUES (65, 'a9efdebe1f4e4139b775ebbf3cba87f0', 2, 1, 3, 4);
INSERT INTO `sheep` VALUES (66, 'b42672e62df84001955cd3b332846134', 1, 0, 1, 27);
INSERT INTO `sheep` VALUES (67, '653576cda5b84f60afe10e88dd390d5c', 1, 1, 2, 28);
INSERT INTO `sheep` VALUES (68, 'e53dc9b2018246528e0228fc197cb017', 2, 3, 1, 29);
INSERT INTO `sheep` VALUES (69, '55c1564064af4cfe8ccebc767fe660af', 1, 2, 2, 7);
INSERT INTO `sheep` VALUES (70, '543d93f327a44387a354b73f8eac6374', 2, 1, 3, 7);
INSERT INTO `sheep` VALUES (71, 'bdc079c2a2124f9ea2a821b0af779a67', 2, 3, 1, 3);
INSERT INTO `sheep` VALUES (73, '3c0a304c7eb8415c8e81ef18061ef7a1', 1, 1, 1, 1);
INSERT INTO `sheep` VALUES (74, '2614e2876b3946368d2f563bcd1c5b44', 1, 3, 1, 9);
INSERT INTO `sheep` VALUES (77, '2bf30111ff334a8982c10f7aaa5d402d', 2, 5, 1, 4);
INSERT INTO `sheep` VALUES (78, '783d8c37db1e48039780000a450607b4', 1, 3, 2, 5);

-- ----------------------------
-- Table structure for sheep_category
-- ----------------------------
DROP TABLE IF EXISTS `sheep_category`;
CREATE TABLE `sheep_category`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `sheep_category_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sheep_category_address` varchar(800) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `create_time` date NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sheep_category
-- ----------------------------
INSERT INTO `sheep_category` VALUES (1, '新疆细毛羊', '新疆，青海，内蒙古均有分布', '2025-02-19');
INSERT INTO `sheep_category` VALUES (2, '大尾寒羊', '河北、、河南、山东等地区', '2025-02-03');
INSERT INTO `sheep_category` VALUES (3, '蒙古羊', '内蒙古地区', '2025-02-09');
INSERT INTO `sheep_category` VALUES (4, '藏羊', '西藏地区', '2025-02-09');
INSERT INTO `sheep_category` VALUES (5, '东北细毛羊', '东北地区', '2025-02-09');
INSERT INTO `sheep_category` VALUES (6, '中卫山羊', '宁夏', '2025-02-09');
INSERT INTO `sheep_category` VALUES (7, '马头山羊', '湖南，湖北西部山区', '2025-02-09');
INSERT INTO `sheep_category` VALUES (8, '南江黄羊', '四川南江县', '2025-02-09');
INSERT INTO `sheep_category` VALUES (9, '阿勒泰羊', '新疆北部地区', '2025-02-09');
INSERT INTO `sheep_category` VALUES (10, '哈萨克羊', '天山北麓', '2025-02-09');
INSERT INTO `sheep_category` VALUES (27, '岩羊', '青海，内蒙古地区', '2025-02-17');
INSERT INTO `sheep_category` VALUES (28, '湖羊', '甘肃，青海', '2025-01-01');
INSERT INTO `sheep_category` VALUES (29, '陕北白绒山羊', '陕西北部', '2025-02-20');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, '工藤新一', '123456', '20250218173535.jpg');
INSERT INTO `sys_user` VALUES (2, '张敏', '123456', '20250219163630.jpg');
INSERT INTO `sys_user` VALUES (4, '徐佳怡', 'xjy520', '20250425145114.jpg');

SET FOREIGN_KEY_CHECKS = 1;
