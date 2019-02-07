-- Brett Barinaga
-- CPSC 321
-- Extra Credit
-- ec.sql
-- 12/13/2018

DROP TABLE IF EXISTS check_five;
DROP TABLE IF EXISTS check_four;
DROP TABLE IF EXISTS check_three;
DROP TABLE IF EXISTS check_two;
DROP TABLE IF EXISTS check_one;

-- All examples will be explained in the design document/ walk through


-- The check Clause examples


CREATE TABLE check_one (
	username varchar(50),
	password varchar(50),
	account_type varchar(50),
	id INT,
	PRIMARY KEY (id),
	check(account_type in ('Checking', 'Savings', 'Joint', 'Special'))
)engine=InnoDB;

CREATE TABLE check_two (
	state varchar(50),
	capital varchar(50),
	population INT,
	area INT,
	PRIMARY KEY (state),
	check(state in ('Washington', 'Oregon', 'Idaho', 'Montana'))
)engine=InnoDB;

CREATE TABLE check_three (

)engine=InnoDB;