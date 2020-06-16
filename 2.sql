CREATE SCHEMA `2` ;

CREATE TABLE `2`.`Users` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NAME` TEXT NULL,
  PRIMARY KEY (`ID`));

CREATE TABLE `2`.`Labor` (
  `UserID` INT NOT NULL,
  `WorkDay` DATE NULL,
  PRIMARY KEY (`UserID`));

CREATE TABLE `2`.`Calendar` (
  `workday` DATE NOT NULL,
  PRIMARY KEY (`workday`));

-- таблица Calendar (workday)
INSERT INTO `2`.`Calendar` (`workday`) VALUES ('2020-04-21');
INSERT INTO `2`.`Calendar` (`workday`) VALUES ('2020-04-22');
INSERT INTO `2`.`Calendar` (`workday`) VALUES ('2020-04-23');
INSERT INTO `2`.`Calendar` (`workday`) VALUES ('2020-04-24');
INSERT INTO `2`.`Calendar` (`workday`) VALUES ('2020-04-25');
-- таблица Labor (UserID, WorkDay)
INSERT INTO `2`.`Labor` (`UserID`, `WorkDay`) VALUES ('1', '2020-04-21');
INSERT INTO `2`.`Labor` (`UserID`, `WorkDay`) VALUES ('2', '2020-04-22');
INSERT INTO `2`.`Labor` (`UserID`, `WorkDay`) VALUES ('3', '2020-04-23');
INSERT INTO `2`.`Labor` (`UserID`, `WorkDay`) VALUES ('4', '2020-04-25');
INSERT INTO `2`.`Labor` (`UserID`, `WorkDay`) VALUES ('5', '2020-04-25');
-- таблица Users (ID, NAME)
INSERT INTO `2`.`Users` (`ID`, `NAME`) VALUES ('1', 'Егор');
INSERT INTO `2`.`Users` (`ID`, `NAME`) VALUES ('2', 'Али ');
INSERT INTO `2`.`Users` (`ID`, `NAME`) VALUES ('3', 'Алексей');
INSERT INTO `2`.`Users` (`ID`, `NAME`) VALUES ('4', 'Макс');
INSERT INTO `2`.`Users` (`ID`, `NAME`) VALUES ('5', 'Алина');


-- Цель 1. Вывести таблицу вида (Дата, Имена пользователей, кто работает в этот день (Через запятую) ).

SELECT `C`.`workday` as `Дата` ,
       Group_concat(`U`.`NAME`) as `Имена пользователей`
FROM   `Calendar` `C`
       LEFT JOIN `Labor` as `L`
               ON `L`.`WorkDay` = `C`.`workday`
		LEFT JOIN `Users` as `U`
               ON `L`.`UserID` = `U`.`ID`
WHERE `U`.`NAME` IS NOT NULL
GROUP BY `C`.`workday`
