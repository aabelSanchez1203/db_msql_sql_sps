/*
 Navicat Premium Data Transfer

 Source Server         : HotelePalace
 Source Server Type    : MySQL
 Source Server Version : 100419
 Source Host           : localhost:3306
 Source Schema         : practica_dp

 Target Server Type    : MySQL
 Target Server Version : 100419
 File Encoding         : 65001

 Date: 25/04/2022 11:38:20
*/

CREATE DATABASE [IF NOT EXISTS] practica_dp;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for addresses
-- ----------------------------
DROP TABLE IF EXISTS practica_dp.`addresses`;
CREATE TABLE practica_dp.`addresses`  (
  `Id_Distribuidor` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Calle` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Numero_Casa` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Colonia` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of addresses
-- ----------------------------

-- ----------------------------
-- Table structure for distributors
-- ----------------------------
DROP TABLE IF EXISTS practica_dp.`distributors`;
CREATE TABLE practica_dp.`distributors`  (
  `Id` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Fecha_Registro` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of distributors
-- ----------------------------

-- ----------------------------
-- Table structure for persons
-- ----------------------------
DROP TABLE IF EXISTS practica_dp.`persons`;
CREATE TABLE practica_dp.`persons`  (
  `Id_Distribuidor` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Apellido_Paterno` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Apellido_Materno` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of persons
-- ----------------------------

-- ----------------------------
-- Procedure structure for GUARDAR_DISTRIBUIDOR
-- ----------------------------
DROP PROCEDURE IF EXISTS practica_dp.`GUARDAR_DISTRIBUIDOR`;
delimiter ;;
CREATE PROCEDURE practica_dp.`GUARDAR_DISTRIBUIDOR`(IN `BAN` INT,
	IN `ID_I` VARCHAR(25),
	IN `NOMBRE_I` VARCHAR(120),
	IN `APELLIDOP_I` VARCHAR(120),
	IN `APELLIDOM_I` VARCHAR(120),
	IN `CALLE_I` VARCHAR(120),
	IN `NUMERO_I` VARCHAR(120),
	IN `COLONIA_I` VARCHAR(120))
BEGIN

	-- 1. Guarda un registro y guarda cambios
	DECLARE hasError BOOLEAN DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR sqlexception SET hasError = 1;
	
	CASE
		WHEN BAN = 1 THEN
			
			START TRANSACTION;
			
				INSERT INTO distributors 
					(
						Id,
						Fecha_Registro
					) 
					VALUES 
					(
						ID_I,
						NOW()
					);
					
				INSERT INTO persons 
				(
					Id_Distribuidor,
					Nombre,
					Apellido_Paterno,
					Apellido_Materno
				) 
				VALUES 
				(
					ID_I,
					NOMBRE_I,
					APELLIDOP_I, 
					APELLIDOM_I
				);
					
				INSERT INTO addresses 
				(
					Id_Distribuidor,
					Calle,
					Numero_Casa,
					Colonia
				) 
				VALUES 
				(
					ID_I,
					CALLE_I,
					NUMERO_I, 
					COLONIA_I
				);
					
			IF hasError THEN
		
				ROLLBACK;
				SELECT 'error';
				
			ELSE
		 
				COMMIT;
				
			END IF;
			
	END CASE;

END
;;
delimiter ;