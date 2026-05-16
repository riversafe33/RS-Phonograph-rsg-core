CREATE TABLE IF NOT EXISTS `phonographs` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `owner_citizenid` VARCHAR(50) DEFAULT NULL,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `z` double DEFAULT NULL,
  `rot_x` double DEFAULT NULL,
  `rot_y` double DEFAULT NULL,
  `rot_z` double DEFAULT NULL,
  PRIMARY KEY (`id`)
);