/*SELECT pid, code FROM person JOIN (SELECT pid, code FROM activity JOIN (SELECT code FROM project) AS project ON activity.pcode = project.code) AS activity ON person.id = activity.pid;*/
/* FOR POSTGRESQL */
DROP TABLE IF EXISTS activity;
DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS project;

CREATE TABLE person(
  id integer,
  name varchar(255),
  age integer,
  primary key (id)
);

CREATE TABLE project(
  code varchar(255),
  name varchar(255), 
  primary key (code)
);

CREATE TABLE activity(
  id integer,
  pid integer,
  pcode varchar(255),
  name varchar(255),
  startdate timestamp,
  enddate timestamp,
  primary key (id),
  foreign key (pid) REFERENCES person(id),
  foreign key (pcode) REFERENCES project(code)
);

INSERT INTO person (id, name, age) VALUES
(1, 'Bob', 25),
(2, 'Alice', 32),
(3, 'John', 32),
(4, 'Julie', 15),
(5, 'Jessie', 25),
(6, 'Jane', 25),
(7, 'Jack', 25),
(8, 'Fred', 25),
(9, 'Amy', 25),
(10, 'Albert', 25),
(11, 'Brandon', 25),
(12, 'Michael', 25),
(13, 'Nicolas', 25),
(14, 'Zack', 25),
(15, 'William', 25),
(16, 'Wally', 25),
(17, 'Bart', 25),
(18, 'Lisa', 25);

INSERT INTO project (code, name) VALUES
('p1', 'P1'),
('p2', 'P2'),
('p3', 'P3'),
('p4', 'P4'),
('p5', 'P5'),
('p6', 'P6'),
('p7', 'P7'),
('p8', 'P8');

INSERT INTO activity (id, pid, pcode, name, startdate, enddate) VALUES 
(1, 1, 'p1', 'activity1', '2015-08-30 00:00:00', '2016-08-30 00:00:00'),
(2, 1, 'p3', 'activity2', '2016-07-30 00:00:00', '2016-08-25 00:00:00'),
(3, 2, 'p1', 'activity3', '2016-05-22 00:00:00', '2016-06-26 00:00:00'),
(4, 2, 'p2', 'activity4', '2016-02-16 00:00:00', '2016-05-26 00:00:00'),
(5, 2, 'p3', 'activity5', '2015-01-01 00:00:00', '2016-02-26 00:00:00'),
(6, 3, 'p2', 'activity6', '2016-05-24 00:00:00', '2016-07-26 00:00:00'),
(7, 3, 'p3', 'activity7', '2015-03-03 00:00:00', '2016-04-26 00:00:00'),
(8, 4, 'p1', 'activity8', '2014-12-02 00:00:00', '2016-12-26 00:00:00'),
(9, 4, 'p4', 'activity9', '2015-01-12 00:00:00', '2016-10-18 00:00:00'),
(10, 5, 'p1', 'activity10', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(11, 5, 'p2', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(12, 5, 'p3', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(13, 5, 'p7', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(14, 6, 'p6', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(15, 6, 'p7', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(16, 7, 'p1', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(17, 8, 'p1', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(18, 8, 'p5', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(19, 8, 'p6', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(20, 8, 'p7', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(21, 8, 'p8', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(22, 9, 'p8', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(23, 11, 'p1', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(24, 11, 'p2', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(25, 12, 'p3', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(26, 12, 'p4', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(27, 12, 'p5', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(28, 13, 'p2', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(29, 14, 'p1', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(30, 14, 'p2', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(31, 14, 'p3', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(32, 14, 'p4', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(33, 15, 'p3', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(34, 16, 'p1', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(35, 16, 'p2', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(36, 17, 'p4', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(37, 17, 'p5', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(38, 17, 'p6', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(39, 17, 'p7', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(40, 17, 'p8', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(41, 18, 'p1', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(42, 18, 'p3', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(43, 18, 'p4', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00'),
(44, 18, 'p6', 'activity11', '2016-12-20 00:00:00', '2016-12-26 00:00:00');
