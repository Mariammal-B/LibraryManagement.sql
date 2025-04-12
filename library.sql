# CREATING A DATABASE NAMED LIBRARY #
-- create database library

# USING THE DATABASE #
-- use library;

# CREATING TABLES FOR LIBRARY MANAGEMENT #
# TABLE NAME: BOOKDETAILS [ TO STORE THE DETAILS OF THE BOOKS ] #
/*
 create table bookdetails(
 bookid int auto_increment primary key,
 title varchar(200) not null,
 author varchar(200),
 bookcode varchar(20) unique,
 publishedyear int,
 copiesavailable int default 1
 );
 */
  -- desc bookdetails;
 
 # TABLE NAME: MEMBERS [ TO STORE THE DETAILS OF THE MEMBERS AT THE LIBRARY ] #
 /*
 create table members(
 memberid int auto_increment primary key,
 name varchar(100) not null,
 email varchar(100) unique,
 phone varchar(15),
 address text,
 membershipdate timestamp default current_timestamp
 );
 */
--  desc members; 

 # TABLE NAME: BOOKISSUE [ TO STORE THE DETAILS OF THE ISSUED BOOK ] #
 /*
 create table bookissue(
 bookissueid int auto_increment primary key,
 bookid int,
 memberid int,
 issuedate timestamp default current_timestamp,
 duedate timestamp not null,
 foreign key ( bookid) references bookdetails(bookid),
 foreign key (memberid) references members(memberid)
 );
 */
 -- desc bookissue;
 
 # TABLE NAME : BOOKRETURN [ TO STORE THE DETAILS OF WHEN THE BOOK HAS BEEN RETURNED TO THE LIBRARY ]
 /*
 create table bookreturn(
 returnid int auto_increment primary key,
 bookissueid int,
 returndate timestamp default current_timestamp,
 fine decimal(10,2) default 0,
 foreign key(bookissueid) references bookissue(bookissueid)
 );
 */
 -- desc bookreturn;
 # INSERTING DATA OR ADDING A NEW BOOK  INTO THE BOOKDETAILS TABLES #
  -- insert into bookdetails (title, author,bookcode,publishedyear,copiesavailable) values ("Shakespear's tales","shakespeare",4356754768,2009,10);
  -- insert into bookdetails (title, author,bookcode,publishedyear,copiesavailable) values ("The Merchant of venice","shakespeare",4356754769,2006,8);
  -- insert into bookdetails (title, author,bookcode,publishedyear,copiesavailable) values ("sql cookbook","Anthony Molinaro",4357754768,1998,15);
 --  insert into bookdetails (title, author,bookcode,publishedyear,copiesavailable) values ("Sql database","chris",435675456,2009,12);
  -- insert into bookdetails (title, author,bookcode,publishedyear,copiesavailable) values ("Java: seventh edition","Helbert",2356754768,2000,11);
  -- insert into bookdetails (title, author,bookcode,publishedyear,copiesavailable) values ("Fundementals of mathematical statistics","sultan chand",485867774768,1997,8);
  -- select * from bookdetails
  
  # INSERTING DATA OR REGISTERING A NEW MEMBER INTO THE MEMBERS TABLES #
    -- insert into members(name, email, phone, address) values ("Mari", "mari4120@gmail.com",8825626263,"vinayagar temple, tirunelveli-06");
     -- insert into members(name, email, phone, address) values ("Ramya", "ramya1930@gmail.com",638096543,"12,thachanallur street, tirunelveli-07");
    -- insert into members(name, email, phone, address) values ("Vinay", "vinay4200@gmail.com",675365552,"13,sn high road, tirunelveli-06");
    -- select * from members
    
    # UPDATING A BOOKS TABLE WHEN ISSUING A BOOK # 
    # TO ACHIEVE THAT WE NEED INSERT AND UPDATE QUERIES #
    # IN INSERT QUERY, THE DETAILS OF BOOKISSUE HAS BEEN STORED ALONG WITH THE DUE DATE USING INTERVAL #
     -- insert into bookissue(bookid,memberid,duedate) values (2,1, date_add(now(), interval 1 minute));
     -- select * from bookissue
    
    # TO UPDATE THE COPIES AFTER BOOK ISSUE #
    -- update bookdetails set copiesavailable = copiesavailable - 1 where bookid = 1;
      -- update bookdetails set copiesavailable = copiesavailable + 1 where bookid = 1;
 -- select * from bookdetails
 
 # INSERT INTO BOOKRETURN TABLE WHEN THE BOOK IS RETURNING BY A MEMBER #
--  insert into bookreturn(bookissueid, fine) values ( 1, 0);
--  delete from bookissue where bookissueid = 1;
-- update bookdetails set copiesavailable = copiesavailable + 1 where bookid = 1;
  -- select * from bookreturn
 
 # CALCULATING FINE AMOUNT USING CASE IF THE RETURNING OF A BOOK DELAYED AFTER THE DUEDATE #
 
 /*
 insert into bookreturn (bookissueid, returndate, fine)
 select bookissueid, current_timestamp(),
 case
 when timestampdiff(minute,duedate,current_timestamp()) > 0 then timestampdiff(minute, duedate, current_timestamp()) * 1
 else 0 
end
from bookissue
where bookissueid = 2;
*/
-- select * from bookreturn

# MEMBER'S DETAILS ALONG WITH THE ISSUED BOOK DETAILS #
  -- select members.memberid, members.name, members.email, bookdetails.title, bookdetails.author, bookissue.issuedate, bookissue.duedate from bookissue join members on bookissue.memberid = members.memberid join bookdetails on bookissue.bookid = bookdetails.bookid;
-- use library;

# QUERY FOR VIEWING MEMBERS AND THE BOOKS THEY HAVE RETURNED #
-- use library;
/*
select
 members.memberid,
 members.name,
 bookdetails.title,
 bookreturn.returndate,
 bookreturn.fine
 from bookreturn join bookissue on bookreturn.bookissueid = bookissue.bookissueid join bookdetails on bookissue.bookid = bookdetails.bookid join members on bookissue.memberid = members.memberid;
*/


# OVERDUE MEMBERS DETAILS #
/*
select 
members.memberid,
members.name,
bookdetails.title,
bookissue.duedate,
timestampdiff(minute, bookissue.duedate, now()) as Overduedays from bookissue join members on bookissue.memberid = members.memberid join bookdetails on bookissue.bookid = bookdetails.bookid where bookissue.duedate < now();
*/

# QUERY TO RETRIEVE THE BOOK DETAILS THAT HAS BEEN TAKEN BY A SPECIFIC MEMBER #
/*
SELECT 
    Bookdetails.bookid, 
    Bookdetails.Title,
    Bookdetails.Author, 
    bookissue.issuedate, 
    bookissue.DueDate, 
    Members.Memberid, 
    Members.Name, 
    Members.Email, 
    Members.Phone
FROM bookissue
JOIN Bookdetails ON bookissue.bookID = Bookdetails.BookID
JOIN Members ON bookissue.MemberID = Members.MemberID 
WHERE Members.Name = 'Mari';  
*/


# CREATING AN EMPLOYEE WHO WORKS IN THE LIBRARY #
 # TABLE NAME: employees [ TO STORE THE EMPLOYEES'S DETAILS WHO WORKS IN THE LIBRARY ] #
 /*
CREATE TABLE employees (
    employeeid INT AUTO_INCREMENT PRIMARY KEY,
    empname VARCHAR(100) NOT NULL,
    empemail VARCHAR(100) UNIQUE,
    empphone VARCHAR(15),
    position VARCHAR(50)
);
*/
-- desc employees;
# MODIFY THE BOOKISSUE TABLE TO LINK THE EMPLOYEE ID #
/*
ALTER TABLE bookissue ADD COLUMN employeeid INT;
ALTER TABLE bookissue ADD FOREIGN KEY (employeeid) REFERENCES employees(employeeid);
*/
 -- desc bookissue;


# INSERT DATA INTO EMPLOYEES TABLE #
/*
INSERT INTO employees (empname, empemail, empphone, position) VALUES
('Alicent', 'alicent@gmail.com', '1234567890', 'Librarian'),
('Billy', 'bobbily@examplegmail.com', '9876543210', 'Assistant Librarian');
-- select * from employees
*/


# INSERTING VALUES TO THE BOOKISSUE TABLE AND THE BOOKS'S BEEN ISSUED BY THE TWO DIFFERENT EMPLOYEES #
/*
INSERT INTO bookissue (bookid, memberid, issuedate, duedate, employeeid) 
VALUES 
(1, 2, NOW(), DATE_ADD(NOW(), INTERVAL 1 minute), 1),  
(2, 3, NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY), 2);   
-- select * from members
-- select * from bookissue
*/

# QUERY TO GET MEMBERS WHO HAVE TAKEN BOOKS FROM A PARTICULAR EMPLOYEE #
/*
SELECT 
    Members.MemberID, Members.Name , 
    Bookdetails.Title , 
    bookissue.issueDate, bookissue.DueDate, 
    employees.empname AS IssuedBy
FROM bookissue
JOIN Members ON bookissue.MemberID = Members.MemberID
JOIN Bookdetails ON bookissue.BookID = Bookdetails.BookID
JOIN Employees ON bookissue.EmployeeID = Employees.EmployeeID
WHERE Employees.empname = 'Alicent';  
*/

 # QUERY TO COUNT BOOKS ISSUED BY EACH EMPLOYEE #
 /*
 SELECT 
    Employees.empName AS EmployeeName, 
    COUNT(bookissue.bookissueid) AS TotalBooksIssued
FROM bookissue
JOIN Employees ON bookissue.EmployeeID = Employees.EmployeeID
GROUP BY Employees.EmployeeID;

*/

/*
ALTER TABLE bookreturn ADD COLUMN employeeid INT;
ALTER TABLE bookreturn ADD FOREIGN KEY (employeeid) REFERENCES Employees(employeeid);
*/

# QUERY TO INSERT DATAS INTO THE BOOKRETURN TABLE AS WELL AS THE FINE COLLECTION TO KNOW THAT THE BOOK HAS BEEN RETURNED TO WHICH SPECIFIC EMPLOYEE #

/*
insert into bookreturn (bookissueid, returndate, fine, employeeid)
 select bookissueid, current_timestamp(),
 case
 when timestampdiff(minute,duedate,current_timestamp()) > 0 then timestampdiff(minute, duedate, current_timestamp()) * 1
 else 0 
end, 2 
from bookissue
where bookissueid = 7;
*/
-- select * from bookreturn


# QUERY FOR EMPLOYEE DETAILS WHO COLLECTED THE FINE #
/*
SELECT 
    Employees.EmployeeID, Employees.empName AS EmployeeName, 
    Employees.empEmail, Employees.empPhone, 
    bookreturn.bookissueID, bookreturn.fine, bookreturn.returndate
FROM bookreturn
JOIN Employees ON bookreturn.employeeid = employees.employeeid
where bookreturn.fine>0;

 -- select * from bookreturn;
 */
 -- delete from bookissue where bookissueid = 7 and fine > 3000


 