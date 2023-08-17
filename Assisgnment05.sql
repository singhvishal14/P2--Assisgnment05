CREATE DATABASE Assessment05Db;

-- Use the database
USE Assessment05Db;

-- Create the schema
CREATE SCHEMA bank;

-- Create the Customer table
CREATE TABLE bank.Customer (
    Cld INT PRIMARY KEY,
    CName VARCHAR(100) NOT NULL,
    CEmail VARCHAR(100) NOT NULL UNIQUE,
    Contact VARCHAR(20) NOT NULL UNIQUE,
    CPwd AS RIGHT(CName + CAST(Cld AS VARCHAR) + LEFT(Contact, 2), 4) PERSISTED
);


-- Insert data into Customer table
INSERT INTO bank.Customer (Cld, CName, CEmail, Contact)
VALUES
    (1000, 'Ram Singh', 'Ram.S@example.com', '3214567890'),
    (1001, 'Ravi kumar', 'ravi.kumar@example.com', '7654321890');

INSERT INTO bank.Customer (Cld, CName, CEmail, Contact)
VALUES
    (1002, 'Punit Shukla', 'punit@example.com', '5432167777'),
    (1003, 'Mahi Gill', 'mahi@example.com', '6543218970');

select * from bank.Customer

-- Create the Maillnfo table
CREATE TABLE bank.Maillnfo (
    MailTo VARCHAR(100),
    MailDate DATE,
    MailMessage VARCHAR(200)
);

-- Create the trigger trgMailToCust
CREATE TRIGGER trgMailToCus
ON bank.Customer
AFTER INSERT
AS
BEGIN
    INSERT INTO bank.Maillnfo (MailTo, MailDate, MailMessage)
    SELECT i.CEmail, GETDATE(), 'Your net banking password is: ' + i.CPwd + '. It is valid up to 2 days only. Update it.'
    FROM inserted i;
END;


-- Inserted data into Maillnfo table using the trigger will be automatically created when you insert into the Customer table
-- Just execute the following select statement to see the inserted data in the Maillnfo table
select * from bank.Maillnfo;