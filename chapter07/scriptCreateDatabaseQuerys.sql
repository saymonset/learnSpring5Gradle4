


 DROP DATABASE MUSICDB
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
  , BIRTH_DATE DATE, VERSION INT NOT NULL DEFAULT 0
  , UNIQUE UQ_SINGER_1 (FIRST_NAME, LAST_NAME)
  , PRIMARY KEY (ID)
);
CREATE TABLE ALBUM (
  ID INT NOT NULL AUTO_INCREMENT
  , SINGER_ID INT NOT NULL
  , TITLE VARCHAR(100) NOT NULL
  , RELEASE_DATE DATE
  , VERSION INT NOT NULL DEFAULT 0
  , UNIQUE UQ_SINGER_ALBUM_1 (SINGER_ID, TITLE)
  , PRIMARY KEY (ID)
  , CONSTRAINT FK_ALBUM_SINGER FOREIGN KEY (SINGER_ID)
  REFERENCES SINGER (ID)
);
CREATE TABLE INSTRUMENT (
    INSTRUMENT_ID VARCHAR(20) NOT NULL
     , PRIMARY KEY (INSTRUMENT_ID)
  );
CREATE TABLE SINGER_INSTRUMENT (
  SINGER_ID INT NOT NULL
   , INSTRUMENT_ID VARCHAR(20) NOT NULL
   , PRIMARY KEY (SINGER_ID, INSTRUMENT_ID)
   , CONSTRAINT FK_SINGER_INSTRUMENT_1 FOREIGN KEY (SINGER_ID)
    REFERENCES SINGER (ID) ON DELETE CASCADE
   , CONSTRAINT FK_SINGER_INSTRUMENT_2 FOREIGN KEY (INSTRUMENT_ID)
   REFERENCES INSTRUMENT (INSTRUMENT_ID)
);

insert into SINGER (first_name, last_name, birth_date) values  ('John', 'Mayer', '1977-10-16');
insert into SINGER (first_name, last_name, birth_date) values  ('Eric', 'Clapton', '1945-03-30');
insert into SINGER (first_name, last_name, birth_date) values  ('John', 'Butler', '1975-04-01');
insert into ALBUM (singer_id, title, release_date) values  (1, 'The Search For Everything', '2017-01-20');
insert into ALBUM (singer_id, title, release_date) values  (1, 'Battle Studies', '2009-11-17');


insert into INSTRUMENT (instrument_id) values ('Guitar');
insert into INSTRUMENT (instrument_id) values ('Piano');
insert into INSTRUMENT (instrument_id) values ('Voice');
insert into INSTRUMENT (instrument_id) values ('Drums');
insert into INSTRUMENT (instrument_id) values ('Synthesizer');

insert into SINGER_INSTRUMENT(singer_id, instrument_id) values (1, 'Guitar');
insert into SINGER_INSTRUMENT(singer_id, instrument_id) values (1, 'Piano');
insert into SINGER_INSTRUMENT(singer_id, instrument_id) values (2, 'Guitar');