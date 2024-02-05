

--Group 21 CreateDB.sql File
--G�kmen CAGLAR
--Defne SAHAL
--Mehmet Anil AKGUL


--We created this createdb.sql file with using backup option.
--So it contains some generic declarations in it I didnt want to erase them 
--to keep this createdb.sql file valid for any restores to any other databases.
--So I will try to mark unnececery and neccecery parts to help your reading.






--GENERIC PRINTS FROM PostgreSQL---------------------------------------------------------------------
-- Started on 2021-05-15 09:04:58

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;



CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;



COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;


--END OF THE GENERIC PRINTS---------------------------------------------------------------------







-- Even thought we say that it created by postgreSql backup option.
-- We want to add that while we creating all these things bellow.
-- We used SQL statments like we learned in the class. But while we creating 
-- createdb.sql there is no option to put everthing back together so we selected the database backup(restore)
-- option.







-----TABLE CREATION----------------------------------------------------------------------

CREATE TABLE public.duty (
    dutyid integer NOT NULL,
    dutyname character varying(255) NOT NULL,
    workplace character varying(1000) NOT NULL
);


ALTER TABLE public.duty OWNER TO group21;



CREATE TABLE public.employee (
    employeeid integer NOT NULL,
    name character varying(100) NOT NULL,
    surname character varying(100) NOT NULL,
    workinghour integer NOT NULL,
    hotelid integer NOT NULL,
    dutyid integer,
    totalholidayent numeric NOT NULL,
    usedholidayent numeric NOT NULL
);


ALTER TABLE public.employee OWNER TO group21;



CREATE TABLE public.hotel (
    hotelid integer NOT NULL,
    hotelname character varying(100) NOT NULL,
    country character varying(100) NOT NULL,
    city character varying(100) NOT NULL,
    phone integer NOT NULL,
    rating integer NOT NULL,
    district character varying
);


ALTER TABLE public.hotel OWNER TO group21;




--VIEW-------------------------------------------------------------
--With this creation of view we filled our view as we selected in statment.
--So actually it has inserts with it.
--But for delete and update statments postgreSql wants trigger functions
--Since we don't know them for know. we didnt updated data from view.
CREATE VIEW  employeelist AS
SELECT employeeid, employee.name, workinghour, hotel.country
FROM employee, hotel
WHERE hotel.hotelid=employee.hotelid 
	AND workinghour > (SELECT avg(workinghour) FROM employee)
	AND hotel.country='t�rkiye';

-------End of View------------------------------------------------------------------	

ALTER TABLE public.employeelist OWNER TO group21;



CREATE TABLE public.guest (
    guestid integer NOT NULL,
    mail character varying(100) NOT NULL,
    phone bigint NOT NULL,
    guestname character varying(50) NOT NULL,
    surname character varying(50) NOT NULL,
    hotelid integer
);


ALTER TABLE public.guest OWNER TO group21;



CREATE TABLE public.payment (
    paymentid integer NOT NULL,
    paymentmethod character varying(50) NOT NULL,
    guestid integer,
    reservationid integer
);


ALTER TABLE public.payment OWNER TO group21;



CREATE TABLE public.reservation (
    reservationid integer NOT NULL,
    guestid integer,
    checkoutdate date NOT NULL,
    checkindate date NOT NULL,
    reservdate date,
    roomid integer,
    hotelid integer
);


ALTER TABLE public.reservation OWNER TO group21;



CREATE TABLE public.room (
    roomid integer NOT NULL,
    roomprice integer NOT NULL,
    guestid integer,
    hotelid integer,
    floorno integer NOT NULL,
    roomtypeid integer,
    roomnumber integer NOT NULL
);


ALTER TABLE public.room OWNER TO group21;



CREATE TABLE public.roomtype (
    roomtypeid integer NOT NULL,
    bedcount integer NOT NULL,
    airconditioning boolean NOT NULL,
    seasight boolean NOT NULL,
    minibar boolean NOT NULL,
    housekeeping boolean NOT NULL
);

ALTER TABLE public.roomtype OWNER TO group21;


-----TABLE CREATION ENDS------------------------------------------------------


--ALTER TABLE--------------------------------------------------------
--We created this createdb.sql file with using backup option of  postgres.sql .
--So it contains some generic alter tables function but we
--Also want to put our own alter table statment

--change the column name, from name to guestname in guest table
alter table guest rename column name to guestname;
----------------------------------------------------------------------



------INSERTIONS----------------------------------------------------------------


INSERT INTO public.duty VALUES (60, 'chef', 'kitchen');
INSERT INTO public.duty VALUES (61, 'cleaningpersonnel', 'room');
INSERT INTO public.duty VALUES (62, 'receptionist', 'lobby');
INSERT INTO public.duty VALUES (63, 'securityguard', 'enterance');
INSERT INTO public.duty VALUES (64, 'entertainer', 'garden');
INSERT INTO public.duty VALUES (65, 'soundmanager', 'technicalroom');
INSERT INTO public.duty VALUES (66, 'bartender', 'bar');
INSERT INTO public.duty VALUES (67, 'waiter', 'dininghall');
INSERT INTO public.duty VALUES (69, 'bellboy', 'hallway');
INSERT INTO public.duty VALUES (68, 'lifeguard', 'beach');




INSERT INTO public.employee VALUES (80, 'mehmet', 'özkan', 9, 29, 61, 30, 22);
INSERT INTO public.employee VALUES (81, 'osman', 'osmanoğlu', 10, 28, 61, 30, 30);
INSERT INTO public.employee VALUES (83, 'ahmet', 'özkan', 12, 26, 61, 30, 15);
INSERT INTO public.employee VALUES (85, 'hazal', 'yıldırım', 9, 24, 60, 30, 22);
INSERT INTO public.employee VALUES (86, 'james', 'houston', 12, 23, 66, 30, 30);
INSERT INTO public.employee VALUES (87, 'ırmak', 'özkan', 11, 22, 61, 30, 30);
INSERT INTO public.employee VALUES (89, 'evren', 'sönmez', 9, 20, 69, 30, 19);
INSERT INTO public.employee VALUES (82, 'uzay', 'yılmaz', 11, 27, 69, 30, 23);
INSERT INTO public.employee VALUES (84, 'daisy', 'riley', 13, 25, 61, 30, 30);
INSERT INTO public.employee VALUES (88, 'claire', 'stewart', 10, 21, 62, 30, 16);




INSERT INTO public.guest VALUES (40, 'didemselçuk@gmail.com', 5309178687, 'didem', 'selçuk', 20);
INSERT INTO public.guest VALUES (41, 'matteofrank@gmail.com', 5316829525, 'matteo', 'frank', 21);
INSERT INTO public.guest VALUES (42, 'mısra.özmen@yandex.com', 5329601769, 'mısra', 'özmen', 22);
INSERT INTO public.guest VALUES (43, 'umut.çelik@gmail.com', 5335835452, 'umut', 'çelik', 23);
INSERT INTO public.guest VALUES (44, 'hansclover@gmail.com', 5347023894, 'hans', 'clover', 24);
INSERT INTO public.guest VALUES (45, 'mısramumcu11@yandex.com', 5358644991, 'mısra', 'mumcu', 25);
INSERT INTO public.guest VALUES (46, 'daisywillow@outlook.com', 5366503206, 'daisy', 'willow', 26);
INSERT INTO public.guest VALUES (47, 'mısra.yıldız@outlook.com', 5378033666, 'mısra', 'yıldız', 27);
INSERT INTO public.guest VALUES (48, 'samiselçuk2@outlook.com', 5386874810, 'sami', 'selçuk', 28);
INSERT INTO public.guest VALUES (49, 'andrew.williams@yandex.com', 5397416479, 'andrew', 'williams', 29);




INSERT INTO public.hotel VALUES (23, 'gazelle', 'türkiye', 'bolu', 4550100, 4, 'karacasu');
INSERT INTO public.hotel VALUES (24, 'donatello', 'italya', 'bologna', 4550101, 2, 'imola');
INSERT INTO public.hotel VALUES (26, 'novotel', 'almanya', 'hamburg', 4550111, 2, 'lübecker');
INSERT INTO public.hotel VALUES (27, 'napoleon', 'italya', 'roma', 4551000, 2, 'vittorio');
INSERT INTO public.hotel VALUES (28, 'melia', 'italya', 'napoli', 4551001, 4, 'masaccio');
INSERT INTO public.hotel VALUES (29, 'doubletree', 'ingiltere', 'coventry', 4551111, 3, 'coventry');
INSERT INTO public.hotel VALUES (30, 'gokmen', 'çin', 'honkong', 8642123, 4, 'rasenka');
INSERT INTO public.hotel VALUES (20, 'sheraton', 'türkiye', 'ankara', 4550001, 4, 'cankaya');
INSERT INTO public.hotel VALUES (22, 'titanic', 'türkiye', 'antalya', 4550011, 1, 'muratpasa');
INSERT INTO public.hotel VALUES (21, 'radisson', 'türkiye', 'ankara', 4550010, 3, 'altindag');
INSERT INTO public.hotel VALUES (25, 'patalya', 'türkiye', 'ankara', 4550110, 1, 'kizilcahamam');
INSERT INTO public.hotel VALUES (31, 'contigo', 'nepal', 'tirhut', 5649876, 4, 'sevas');




INSERT INTO public.payment VALUES (160, 'card', 49, 140);
INSERT INTO public.payment VALUES (161, 'card', 48, 141);
INSERT INTO public.payment VALUES (162, 'card', 47, 142);
INSERT INTO public.payment VALUES (163, 'card', 46, 143);
INSERT INTO public.payment VALUES (164, 'card', 45, 144);
INSERT INTO public.payment VALUES (165, 'card', 44, 145);
INSERT INTO public.payment VALUES (166, 'cash', 43, 146);
INSERT INTO public.payment VALUES (167, 'cash', 42, 147);
INSERT INTO public.payment VALUES (168, 'card', 41, 148);
INSERT INTO public.payment VALUES (170, 'card', 48, 149);
INSERT INTO public.payment VALUES (171, 'cash', 47, 148);




INSERT INTO public.reservation VALUES (140, 49, '2020-01-25', '2020-01-10', '2020-01-02', 120, 29);
INSERT INTO public.reservation VALUES (141, 48, '2020-02-20', '2020-02-12', '2020-02-03', 121, 28);
INSERT INTO public.reservation VALUES (142, 47, '2020-10-24', '2020-10-20', '2020-10-15', 122, 27);
INSERT INTO public.reservation VALUES (143, 46, '2020-01-28', '2020-01-12', '2020-01-02', 123, 26);
INSERT INTO public.reservation VALUES (144, 45, '2020-05-10', '2020-05-07', '2020-05-06', 124, 25);
INSERT INTO public.reservation VALUES (146, 43, '2020-01-22', '2020-01-09', '2020-01-02', 126, 23);
INSERT INTO public.reservation VALUES (147, 42, '2020-08-23', '2020-08-11', '2020-08-09', 127, 22);
INSERT INTO public.reservation VALUES (148, 41, '2020-06-30', '2020-06-18', '2020-06-09', 128, 21);
INSERT INTO public.reservation VALUES (149, 40, '2020-10-24', '2020-10-21', '2020-10-11', 129, 20);
INSERT INTO public.reservation VALUES (145, 44, '2020-06-29', '2020-06-18', NULL, 125, 24);




INSERT INTO public.room VALUES (120, 650, 49, 29, 2, 100, 10);
INSERT INTO public.room VALUES (121, 650, 48, 28, 3, 100, 20);
INSERT INTO public.room VALUES (122, 550, 47, 27, 5, 102, 10);
INSERT INTO public.room VALUES (123, 550, 46, 26, 4, 102, 40);
INSERT INTO public.room VALUES (124, 450, 45, 25, 10, 103, 50);
INSERT INTO public.room VALUES (125, 450, 44, 24, 12, 103, 60);
INSERT INTO public.room VALUES (126, 450, 43, 23, 12, 103, 40);
INSERT INTO public.room VALUES (127, 350, 42, 22, 5, 107, 80);
INSERT INTO public.room VALUES (128, 150, 41, 21, 3, 108, 40);
INSERT INTO public.room VALUES (129, 251, 40, 20, 12, 109, 100);



INSERT INTO public.roomtype VALUES (100, 2, true, true, true, true);
INSERT INTO public.roomtype VALUES (101, 2, true, false, false, true);
INSERT INTO public.roomtype VALUES (102, 2, false, true, true, true);
INSERT INTO public.roomtype VALUES (103, 1, true, true, true, true);
INSERT INTO public.roomtype VALUES (104, 1, false, true, true, false);
INSERT INTO public.roomtype VALUES (105, 1, false, true, false, true);
INSERT INTO public.roomtype VALUES (106, 2, false, true, false, false);
INSERT INTO public.roomtype VALUES (107, 2, false, false, true, true);
INSERT INTO public.roomtype VALUES (108, 1, false, false, true, false);
INSERT INTO public.roomtype VALUES (109, 2, false, false, false, true);

------INSERTIONS ENDS----------------------------------------------------------------




--updates---------------------------------------------
--we changed dutyid 68 wokplace pool to beach
UPDATE public.duty
SET workplace='beach'
WHERE dutyid=68;

--we changed employeeid 88's usedHoliday ent value from 10 to 16
UPDATE public.employee
SET usedholidayent=16
WHERE employeeid=88;

--we changed guestid 49's phone number value from 5397416478 to 5397416479
UPDATE public.guest
SET  phone=5397416479
WHERE guestid=49;


--we changed hotelid 31's rating value from 3 to 4
UPDATE public.hotel
SET rating=4
WHERE hotelid=31;


--we changed paymentid 168's paymentsmethod from cash to card
UPDATE public.payment
SET paymentmethod='card'
WHERE paymentid=168;


--we changed reservationid 145's checkoutdate from 2020-06-28 to 2020-06-29
UPDATE public.reservation
SET checkoutdate='2020-06-29'
WHERE reservationid=145;

--we changed roomid 129's roomprice from 250 to 251
UPDATE public.room
SET roomprice=251
WHERE roomid=129;

--we changed roomypeid 109's bedcount from 1 to 2
UPDATE public.roomtype
SET bedcount=2
WHERE roomtypeid=109;
----------------------------------------------------------------------------


--DELETES--------------------------------------------------------------------
--First we inserted then we deleted to keep insertion number at 10.
--But because of the delete you cannot see any of these insertions in the database.

--insert hotel values into hotel table
INSERT INTO hotel (hotelid, hotelname, country, city, district, phone, rating)
VALUES('32', 'adlon', 'almanya', 'berlin', 'mitte', '4550000', '3');
--delete hotel having hotelid equals to 30 from hotel table
delete from hotel where hotelid=32;

--insert new guest into guest table
INSERT INTO guest (guestid, mail, phone, guestname, surname, hotelid)
VALUES('50', 'meltemkar@gmail.com', '5309178696', 'meltem', 'kar', '22');
--delete guest whose name is meltem
delete from guest where guestname='meltem';

--insert new duty into duty table
INSERT INTO duty (dutyid, dutyname, workplace)
VALUES('70', 'gardener', 'garden');
--delete duty which has dutyid 70
delete from duty where dutyid=70;

--insert new employee into employee table
INSERT INTO employee (employeeid, name, surname, workinghour, hotelid, dutyid, totalholidayent, usedholidayent)
VALUES('90', 'erhan', 'tas', '9', '25', '63', '30', '28');
--delete employee with the surname tas
delete from employee where surname='tas';

--insert new roomtype into roomtype table
INSERT INTO roomtype (roomtypeid, bedcount, airconditioning, seasight, minibar, housekeeping)
VALUES('110', '1', '0', '0', '0', '0');
--delete roomtype with the roomtypeid 110
delete from roomtype where roomtypeid=110;

--insert room values into room table
INSERT INTO room (roomid, roomprice, guestid, hotelid, floorno, roomtypeid, roomnumber)
VALUES('130', '200', '49', '21', '3', '108', '10');
--delete room with the roomid 130
delete from room where roomid=130;

--insert new reservation into reservation table
INSERT INTO reservation (reservationid, guestid, checkoutdate, checkindate, reservdate, roomid, hotelid)
VALUES('150', '43', '2020-02-22', '2020-02-09', '2020-01-28', '126', '23');
--delete reservation with the reservationid 150
delete from reservation where reservationid=150;

--insert payment values into payment table
INSERT INTO payment (paymentid, paymentmethod, guestid, reservationid)
VALUES('172', 'card', '46', '147');
--delete payment with the paymentid 172
delete from payment where paymentid=172;

-------END OF THE DELETES----------------------------------------------------------------------

--PostgreSQL created this part automaticly becasue of the backup option.
--But while we are creating these constrains we always created these inside of the 
--create table function.

--So below ones are generic alters.


ALTER TABLE ONLY public.hotel
    ADD CONSTRAINT "Hotel_pkey" PRIMARY KEY (hotelid);

ALTER TABLE public.hotel
    ADD CONSTRAINT rating_check CHECK (((rating < 5) AND (0 < rating))) NOT VALID;

   
ALTER TABLE ONLY public.duty
    ADD CONSTRAINT "dutyName_uniqe" UNIQUE (dutyname);



ALTER TABLE ONLY public.duty
    ADD CONSTRAINT duty_pkey PRIMARY KEY (dutyid);



ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employeeid);



ALTER TABLE ONLY public.guest
    ADD CONSTRAINT guest_pkey PRIMARY KEY (guestid);



ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (paymentid);


ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_pkey PRIMARY KEY (reservationid);



ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_pkey PRIMARY KEY (roomid);



ALTER TABLE ONLY public.roomtype
    ADD CONSTRAINT roomtype_pkey PRIMARY KEY (roomtypeid);



ALTER TABLE public.employee
    ADD CONSTRAINT tot_hol_check CHECK ((totalholidayent = (30)::numeric)) NOT VALID;



ALTER TABLE public.employee
    ADD CONSTRAINT used_hol_check CHECK (((usedholidayent < (31)::numeric) AND ((0)::numeric < usedholidayent))) NOT VALID;



ALTER TABLE ONLY public.employee
    ADD CONSTRAINT duty_id FOREIGN KEY (dutyid) REFERENCES public.duty(dutyid) NOT VALID;



ALTER TABLE ONLY public.payment
    ADD CONSTRAINT guest_fk FOREIGN KEY (guestid) REFERENCES public.guest(guestid) NOT VALID;



ALTER TABLE ONLY public.room
    ADD CONSTRAINT guest_fk FOREIGN KEY (guestid) REFERENCES public.guest(guestid) NOT VALID;



ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT guest_fk FOREIGN KEY (guestid) REFERENCES public.guest(guestid);



ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT hot_fk FOREIGN KEY (hotelid) REFERENCES public.hotel(hotelid);



ALTER TABLE ONLY public.guest
    ADD CONSTRAINT hot_id FOREIGN KEY (hotelid) REFERENCES public.hotel(hotelid);



ALTER TABLE ONLY public.employee
    ADD CONSTRAINT hot_id FOREIGN KEY (hotelid) REFERENCES public.hotel(hotelid);



ALTER TABLE ONLY public.room
    ADD CONSTRAINT hotid_fk FOREIGN KEY (hotelid) REFERENCES public.hotel(hotelid) NOT VALID;



ALTER TABLE ONLY public.payment
    ADD CONSTRAINT res_fk FOREIGN KEY (reservationid) REFERENCES public.reservation(reservationid);



ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_fk FOREIGN KEY (roomtypeid) REFERENCES public.roomtype(roomtypeid);



ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT room_fk FOREIGN KEY (roomid) REFERENCES public.room(roomid);


-- Completed on 2021-05-15 09:05:00

--
-- PostgreSQL database dump complete

   
--GROUP21 DATABASE  
--G�kmen CAGLAR
--Defne SAHAL
--Mehmet Anil AKGUL

