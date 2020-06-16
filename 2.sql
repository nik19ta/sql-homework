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

-- Таблица необходима для второго задания
CREATE TABLE `2`.`vacation` (
  `USER_ID` INT NOT NULL AUTO_INCREMENT,
  `VACATION_START` DATE NULL,
  `VACATION_END` DATE NULL,
  PRIMARY KEY (`USER_ID`));


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
-- Данные для табли vacation (Для второй части этого задания)
INSERT INTO `2`.`vacation` (`USER_ID`, `VACATION_START`, `VACATION_END`) VALUES ('1', '2020-04-21', '2020-04-28');
INSERT INTO `2`.`vacation` (`USER_ID`, `VACATION_START`, `VACATION_END`) VALUES ('2', '2020-05-21', '2020-04-28');
INSERT INTO `2`.`vacation` (`USER_ID`, `VACATION_START`, `VACATION_END`) VALUES ('3', '2020-02-21', '2020-03-21');
INSERT INTO `2`.`vacation` (`USER_ID`, `VACATION_START`, `VACATION_END`) VALUES ('4', '2020-07-21', '2020-08-21');
INSERT INTO `2`.`vacation` (`USER_ID`, `VACATION_START`, `VACATION_END`) VALUES ('5', '2020-04-21', '2020-04-28');

-- Цель 1. Вывести таблицу вида (Дата, Имена пользователей
--  кто работает в этот день (Через запятую) ).

SELECT `C`.`workday` as `Дата` ,
       Group_concat(`U`.`NAME`) as `Имена пользователей`
FROM   `Calendar` `C`
       LEFT JOIN `Labor` as `L`
               ON `L`.`WorkDay` = `C`.`workday`
		LEFT JOIN `Users` as `U`
               ON `L`.`UserID` = `U`.`ID`
WHERE `U`.`NAME` IS NOT NULL
GROUP BY `C`.`workday`

-- Цель 2. Вывести таблицу из ц1, если смена пользователя попадает в интервал его отпуска
-- - в таблице рядом с фамилией должна быть подпись "(в отпуске)"

SELECT `C`.`workday` as `Дата` ,
       Group_concat(`U`.`NAME`, if (`C`.`workday` between `V`.`VACATION_START` and `V`.`VACATION_END`,' (В отпуске)','')) as `Имена пользователей`
FROM   `Calendar` `C`
       LEFT JOIN `Labor` as `L`
               ON `L`.`WorkDay` = `C`.`workday`
		LEFT JOIN `Users` as `U`
               ON `L`.`UserID` = `U`.`ID`
		INNER JOIN `vacation` as `V`
               ON `V`.`USER_ID` = `U`.`ID`

WHERE `U`.`NAME` IS NOT NULL
GROUP BY `C`.`workday`
