 docker run  --name mysql_bd --net bridge -e MYSQL_ROOT_PASSWORD=123456 -e MYSQL_DATABASE=musicdb -e MYSQL_USER=spring -e ALLOW_EMPTY_PASSWORD=yes -e MYSQL_PASSWORD=123456 -p 3312:3306 -d mariadb:5.5


 #scripts  bd

 


CREATE USER 'prospring5'@'localhost' IDENTIFIED BY 'prospring5';
CREATE SCHEMA MUSICDB;
GRANT ALL PRIVILEGES ON MUSICDB . * TO 'prospring5'@'localhost';
FLUSH PRIVILEGES;
/*in case of java.sql.SQLException: The server timezone value 'UTC'
is unrecognized or represents more than one timezone. */

SET GLOBAL time_zone = '+3:00';

 use musicdb;


 CREATE TABLE SINGER (
ID INT NOT NULL AUTO_INCREMENT
, FIRST_NAME VARCHAR(60) NOT NULL
, LAST_NAME VARCHAR(40) NOT NULL
, BIRTH_DATE DATE
, UNIQUE UQ_SINGER_1 (FIRST_NAME, LAST_NAME)
, PRIMARY KEY (ID)
);
CREATE TABLE ALBUM (
ID INT NOT NULL AUTO_INCREMENT
, SINGER_ID INT NOT NULL
, TITLE VARCHAR(100) NOT NULL
, RELEASE_DATE DATE
, UNIQUE UQ_SINGER_ALBUM_1 (SINGER_ID, TITLE)
, PRIMARY KEY (ID)
, CONSTRAINT FK_ALBUM FOREIGN KEY (SINGER_ID)
REFERENCES SINGER (ID)
);

insert into SINGER (first_name, last_name, birth_date) values  ('John', 'Mayer', '1977-10-16');
insert into SINGER (first_name, last_name, birth_date) values  ('Eric', 'Clapton', '1945-03-30');
insert into SINGER (first_name, last_name, birth_date) values  ('John', 'Butler', '1975-04-01');
insert into ALBUM (singer_id, title, release_date) values  (1, 'The Search For Everything', '2017-01-20');
insert into ALBUM (singer_id, title, release_date) values  (1, 'Battle Studies', '2009-11-17');
insert into ALBUM (singer_id, title, release_date) values  (2, ' From The Cradle ', '1994-09-13');