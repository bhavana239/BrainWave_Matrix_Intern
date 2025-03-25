create database library
use library
CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    birth_date DATE,
    nationality VARCHAR(50)
);
CREATE TABLE Publishers (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255),
    phone_number VARCHAR(15),
    email VARCHAR(100)
);
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    author_id INT,
    publisher_id INT,
    publication_year YEAR,
    available_copies INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id),
    FOREIGN KEY (publisher_id) REFERENCES Publishers(publisher_id)
);
CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    address VARCHAR(255),
    phone_number VARCHAR(15),
    email VARCHAR(100),
    membership_date DATE
);
CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    book_id INT,
    issue_date DATE,
    due_date DATE,
    return_date DATE,
    transaction_type VARCHAR(20), -- 'borrow' or 'return'
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);
CREATE TABLE Fines (
    fine_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_id INT,
    fine_amount DECIMAL(10, 2),
    FOREIGN KEY (transaction_id) REFERENCES Transactions(transaction_id)
);
INSERT INTO Authors (first_name, last_name, birth_date, nationality)
VALUES 
('J.K.', 'Rowling', '1965-07-31', 'British'),
('George', 'Orwell', '1903-06-25', 'British'),
('J.R.R.', 'Tolkien', '1892-01-03', 'British');
INSERT INTO Publishers (name, address, phone_number, email)
VALUES 
('Bloomsbury', '50 Bedford Square, London', '020-7631-5600', 'contact@bloomsbury.com'),
('Harvill Secker', '20 Vauxhall Bridge Road, London', '020-7592-1550', 'contact@harvill.com'),
('Houghton Mifflin Harcourt', '215 Park Avenue South, New York', '212-555-1234', 'contact@hmh.com');
INSERT INTO Books (title, author_id, publisher_id, publication_year, available_copies)
VALUES 
('Harry Potter and the Philosopher\'s Stone', 1, 1, 1997, 5),
('1984', 2, 2, 1949, 3),
('The Hobbit', 3, 3, 1937, 4);
INSERT INTO Members (first_name, last_name, address, phone_number, email, membership_date)
VALUES 
('John', 'Doe', '123 Elm St, Springfield', '555-1234', 'john.doe@example.com', '2025-03-01'),
('Jane', 'Smith', '456 Oak St, Springfield', '555-5678', 'jane.smith@example.com', '2025-02-15');
INSERT INTO Transactions (member_id, book_id, issue_date, due_date, transaction_type)
VALUES 
(1, 1, '2025-03-20', '2025-04-20', 'borrow'),
(2, 2, '2025-03-22', '2025-04-22', 'borrow');
INSERT INTO Fines (transaction_id, fine_amount)
VALUES 
(1, 5.00); 
SELECT b.title, a.first_name AS author_first_name, a.last_name AS author_last_name, p.name AS publisher_name, b.available_copies
FROM Books b
JOIN Authors a ON b.author_id = a.author_id
JOIN Publishers p ON b.publisher_id = p.publisher_id
WHERE b.available_copies > 0;

UPDATE Books
SET available_copies = available_copies + 1
WHERE book_id = 1; 


UPDATE Transactions
SET return_date = CURDATE(), transaction_type = 'return'
WHERE transaction_id = 1; 

SELECT t.transaction_id, b.title, t.issue_date, t.due_date, t.return_date, t.transaction_type
FROM Transactions t
JOIN Books b ON t.book_id = b.book_id
WHERE t.member_id = 1;











