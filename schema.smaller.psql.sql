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
(6, 'Jane', 25);

INSERT INTO project (code, name) VALUES
('p1', 'P1'),
('p2', 'P2'),
('p3', 'P3'),
('p4', 'P4');

INSERT INTO activity (id, pid, pcode, name, startdate, enddate) VALUES 
(1, 1, 'p1', 'activity1', '2015-08-30 00:00:00', '2016-08-30 00:00:00'),
(2, 1, 'p3', 'activity2', '2016-07-30 00:00:00', '2016-08-25 00:00:00'),
(3, 2, 'p1', 'activity3', '2016-05-22 00:00:00', '2016-06-26 00:00:00'),
(4, 3, 'p2', 'activity4', '2016-02-16 00:00:00', '2016-05-26 00:00:00'),
(5, 3, 'p3', 'activity5', '2015-01-01 00:00:00', '2016-02-26 00:00:00'),
(6, 4, 'p2', 'activity6', '2016-05-24 00:00:00', '2016-07-26 00:00:00'),
(7, 5, 'p3', 'activity7', '2015-03-03 00:00:00', '2016-04-26 00:00:00'),
(8, 6, 'p1', 'activity8', '2014-12-02 00:00:00', '2016-12-26 00:00:00');

