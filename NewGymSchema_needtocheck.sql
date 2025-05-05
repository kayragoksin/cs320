
CREATE DATABASE IF NOT EXISTS gymdb;
USE gymdb;


CREATE TABLE Member (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    is_premium BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE Instructor (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    password_hash VARCHAR(255) NOT NULL
);

CREATE TABLE Admin (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    password_hash VARCHAR(255) NOT NULL
);


CREATE TABLE Class (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    time DATETIME NOT NULL,
    instructor_id INT NOT NULL,
    capacity INT NOT NULL,
    FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
);


CREATE TABLE Enrollment (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    class_id INT NOT NULL,
    enrolled_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES Member(member_id),
    FOREIGN KEY (class_id) REFERENCES Class(class_id)
);


CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    paid_at DATETIME NOT NULL,
    FOREIGN KEY (member_id) REFERENCES Member(member_id)
);


CREATE TABLE GymStatus (
    is_active BOOLEAN NOT NULL DEFAULT TRUE
);


INSERT INTO GymStatus (is_active)
SELECT TRUE
WHERE NOT EXISTS (SELECT 1 FROM GymStatus);
