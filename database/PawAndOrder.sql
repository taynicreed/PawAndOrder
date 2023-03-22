-- -----------------------------------------------------
-- Group 150 ~ Alyssa Feutz & Taylor Reed
-- Data Definition Queries
-- -----------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;
SET AUTOCOMMIT = 0;

-- -----------------------------------------------------
-- Creating Tables
-- -----------------------------------------------------

-- Create Customers table
CREATE OR REPLACE TABLE Customers (
    customerID int(11) NOT NULL AUTO_INCREMENT,
    customerName varchar(50) NOT NULL,
    altName varchar(50) NULL,
    phone varchar(20) NOT NULL,
    email varchar(50),
    PRIMARY KEY (customerID)
);

-- Create Dogs table
CREATE OR REPLACE TABLE Dogs (
    dogID int(11) NOT NULL AUTO_INCREMENT,
    customerID int(11) NOT NULL,
    dogName varchar(50) NOT NULL,
    dogBirthday date NOT NULL,
    active tinyint(1),
    PRIMARY KEY (dogID),
    FOREIGN KEY (customerID) REFERENCES Customers(customerID) ON DELETE CASCADE
);

-- Create Employees table
CREATE OR REPLACE TABLE Employees (
    employeeID int(11) NOT NULL AUTO_INCREMENT,
    employeeName varchar(50) NOT NULL,
    employeeType varchar(50) NOT NULL,
    PRIMARY KEY (employeeID)
);

-- Create Commands table
CREATE OR REPLACE TABLE Commands (
    commandID int(11) NOT NULL AUTO_INCREMENT,
    commandName varchar(50) NOT NULL,
    PRIMARY KEY (commandID)
);

-- Create TrainingSessions table
CREATE OR REPLACE TABLE TrainingSessions (
    sessionID int(11) NOT NULL AUTO_INCREMENT,
    customerID int(11) NOT NULL,
    dogID int(11) NULL,
    employeeID int(11) NOT NULL,
    sessionDate date NOT NULL,
    notes varchar(300) NOT NULL,
    PRIMARY KEY (sessionID),
    FOREIGN KEY (customerID) REFERENCES Customers(customerID) ON DELETE CASCADE,
    FOREIGN KEY (dogID) REFERENCES Dogs(dogID) ON DELETE CASCADE,
    FOREIGN KEY (employeeID) REFERENCES Employees(employeeID)
    ON DELETE CASCADE
);

-- Create CommandsLearned table
CREATE OR REPLACE TABLE CommandsLearned (
  CommandsLearnedByDog int(11) NOT NULL AUTO_INCREMENT,
  commandID int(11) NOT NULL,
  dogID int(11) NOT NULL,
  PRIMARY KEY (CommandsLearnedByDog),
  FOREIGN KEY (commandID) REFERENCES Commands(commandID),
  FOREIGN KEY (dogID) REFERENCES Dogs(dogID)
  ON DELETE CASCADE

);

-- -----------------------------------------------------
-- Insert Example Data
-- -----------------------------------------------------

-- Insert Customers data
INSERT INTO Customers (customerName, altName, phone, email)
    VALUES ('Martina Hansen','Alyssa Hansen','555-555-5555', 'martina@gmail.com'),
    ('Gail Smith', 'Brenda Smith', '555-555-5556', 'gail@gmail.com'),
    ('Alex Baker', NULL, '555-555-5557', NULL);

-- Insert Dogs data
INSERT INTO Dogs (customerID, dogName, dogBirthday, active)
VALUES (1, 'Spot', '2022-10-20', 1),
(2, 'Josh', '2016-02-01', 1),
(2, 'Potato', '2019-05-07', 1),
(3, 'George', '2013-01-21', 0),
(3, 'Echo', '2015-08-13', 0);

-- Insert Employees data
INSERT INTO Employees (employeeName, employeeType)
VALUES ('Jaime Gomez', 'Trainer'),
("Rachel Li", "Office Manager"),
("Deborah Pasic", "Trainer");

-- Insert Commands data
INSERT INTO Commands (commandName)
VALUES ('Sit'),
('Shake'),
('Down'),
('Heal'),
('Come');

-- Insert TrainingSessions data
INSERT INTO TrainingSessions (customerID, dogID, employeeID, sessionDate, notes)
VALUES (1, 1, 1, "2023-02-04", "Good Boy"),
(2, 2, 1, "2023-02-04", "Good Boy"),
(2, NULL, 1, "2023-02-04", "Reactivity training consultation"),
(1, 1, 3, "2023-02-05", "Ate all the treats, order more"),
(2, 2, 3, "2023-02-05", "Need to revisit down command");

-- Insert CommandsLearned data
INSERT INTO CommandsLearned (commandID, dogID)
VALUES (1, 1),
(3, 1),
(4, 2),
(5, 2);


SET FOREIGN_KEY_CHECKS = 1;
COMMIT;
