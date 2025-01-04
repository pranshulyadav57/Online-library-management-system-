-- Create database
CREATE DATABASE library;

-- Use the database
USE library;

CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(20)
);

CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);
select * from Employee;

CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE
);

CREATE TABLE BOOKS (
    BOOkID INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for each book
    NAME VARCHAR(255) NOT NULL,             -- Name of the book
    AUTHOR VARCHAR(255) NOT NULL,           -- Author of the book
    QUANTITY INT NOT NULL,                  -- Total number of copies of the book
    ISSUED INT DEFAULT 0                    -- Number of issued copies
);

CREATE TABLE IssueBook (
    bookid INT NOT NULL,                   -- Foreign key to BOOKS table
    rno INT NOT NULL,                      -- Roll number of the student
    name VARCHAR(255) NOT NULL,            -- Student's name
    mon BIGINT NOT NULL,                   -- Student's mobile number
    issuedate DATE NOT NULL,               -- Date when the book was issued
    status VARCHAR(50) DEFAULT 'Not Return', -- Status of the issued book
    PRIMARY KEY (bookid, rno),
    FOREIGN KEY (bookid) REFERENCES BOOKS(BOOkID) ON DELETE CASCADE
);

DELIMITER //
CREATE PROCEDURE Library(IN studentid INT, IN bookid INT)
BEGIN
    DECLARE fine INT;
    -- Logic to calculate the fine (if applicable)
    SELECT DATEDIFF(CURRENT_DATE, issuedate) - 14 INTO fine
    FROM IssueBook
    WHERE bookid = bookid AND rno = studentid AND status = 'Not Return';

    IF fine > 0 THEN
        -- Logic to handle fine (e.g., update fine table, log details)
        INSERT INTO FineLog (studentid, bookid, fine_amount)
        VALUES (studentid, bookid, fine);
    END IF;
END //
DELIMITER ;



CREATE TABLE Librarian (
    id INT AUTO_INCREMENT PRIMARY KEY,   -- Unique identifier for each librarian
    name VARCHAR(100) NOT NULL,          -- Librarian's name
    email VARCHAR(100) UNIQUE NOT NULL,  -- Librarian's email address (must be unique)
    password VARCHAR(255) NOT NULL,      -- Password (preferably hashed)
    mobile BIGINT NOT NULL,              -- Librarian's mobile number
    username VARCHAR(100) NOT NULL,      -- Librarian's username (added column)
    CONSTRAINT UNIQUE (username)         -- Unique constraint for username
);
INSERT INTO Librarian (name, email, password, mobile, username)
VALUES ('Pranshul Yadav', 'pranshulyadav57@gmail.com', '12345678', 9876543210, 'pranshul123');
SELECT * FROM Librarian WHERE name = 'Pranshul Yadav' and password = '12345678';

SELECT * FROM Librarian WHERE email = 'pranshulyadav57@gmail.com' AND password = '12345678';




CREATE TABLE studentlogin (
    roll_no INT PRIMARY KEY AUTO_INCREMENT, -- Roll Number (unique for each student)
    name VARCHAR(100) NOT NULL,             -- Name
    branch VARCHAR(50) NOT NULL,            -- Branch
    year_of_study INT NOT NULL,             -- Year of Study
    address TEXT NOT NULL,                  -- Address
    pwd VARCHAR(255) NOT NULL,         -- Password (hashed or plain, depending on implementation)
    email VARCHAR(100) NOT NULL UNIQUE,     -- Email (unique for each student)
    phone VARCHAR(15) NOT NULL,             -- Phone number
    username VARCHAR(50) NOT NULL UNIQUE    -- Username (unique)
);

insert into studentlogin(roll_no , name , branch, year_of_study, address, pwd, email, phone, username)
values (2 , 'Prateek' , 'CSD' , 1, 'Etawah', 'rcbfan' , 'prateek@gmail.com' , '9020000801', 'master_golu');
select * from studentlogin where email = 'prateek@gmail.com' and pwd = 'master_golu' ;


INSERT INTO Branch VALUES (1, 101, '123 Main St, City, Country', '123-456-7890');
INSERT INTO Branch VALUES (2, 102, '456 Side St, Town, Country', '234-567-8901');

INSERT INTO Employee VALUES (101, 'John Doe', 'Manager', 5000.00, 1);
INSERT INTO Employee VALUES (102, 'Jane Smith', 'Assistant', 3000.00, 2);

INSERT INTO Customer VALUES (1, 'Alice Johnson', '789 Oak St, City, Country', '2023-01-15');
INSERT INTO Customer VALUES (2, 'Bob Brown', '321 Pine St, Town, Country', '2023-02-10');


