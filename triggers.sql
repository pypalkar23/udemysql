DROP DATABASE trigger_study;
CREATE DATABASE trigger_study;
USE trigger_study;
CREATE TABLE users(
	id INT PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(45),
    age INT
);

DELIMITER $$
CREATE TRIGGER must_be_adult
	BEFORE INSERT ON users FOR EACH ROW
    BEGIN 
		IF NEW.age < 18
        THEN 
			SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = "Must be an adult!";
		END IF;
	END;
$$
DELIMITER ;



INSERT INTO users(username,age) VALUES('Mandar',24);
INSERT INTO users(username,age) VALUES('Unknown',17);


DELIMITER $$
CREATE TRIGGER must_be_adult
	BEFORE INSERT ON users FOR EACH ROW
    BEGIN 
		IF NEW.age < 18
        THEN 
			SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = "Must be an adult!";
		END IF;
	END;
$$
DELIMITER ;








    
        
			
