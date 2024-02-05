--Group 21 Queries.SQL File
--Gökmen CAGLAR
--Defne SAHAL
--Mehmet Anil AKGUL

--joins
--join involving two tables
--display employees along with their duties
select*
from employee join duty on employee.dutyid= duty.dutyid;


--join involving three tables
--guests having rooms with seasight
select guestid, guestname, surname 
from guest natural join room  
natural join (select roomtypeid
	           from roomtype 
	           where seasight=true) as seasight;

--outer join
--all roomtypes along with their roomid's
select roomid ,roomtype 
from room full outer join roomtype 
on room.roomtypeid =roomtype.roomtypeid 
order by room.roomid ;




--subqueries
--subquery that returns multiple rows
--Find guests with their reservation id's,  who made hotel reservation on 2020-01-02 and didn't pay with cash
select reservationid ,guestid
from reservation
where reservdate= '2020-01-02' and
(guestid) not in (select guestid
		from payment
		where paymentmethod= 'cash');

--scalar subquery
--list all duties and their workplaces along with the number of employees working in each duty
select dutyname,workplace,
	(select count(*)
	from employee
	where duty.dutyid=employee.dutyid)
	as numberofemployees
from duty;
	

--subquery in the from clause
--Find average price of the rooms which cost higher than 400 on each floor
select floorno, avgroomprice
from (select floorno, avg (roomprice) as avgroomprice
		from room
		group by room.floorno
		order by floorno) as avgroomprice
where avgroomprice>400 ;



--queries

--where, and
--find name and district of the hotels in Turkey's Ankara city
select hotelname, district
from hotel
where country='türkiye' and city='ankara';

--or
--finds hotels in Turkey or Germany
select hotelname
from hotel
where country='türkiye' or country='almanya';

--avg
--find average used holidays of employees and group them by their duty id's
select avg(usedholidayent), dutyid
from employee
group by dutyid;

--count
--total number of employees who works more than 10 hours.
select count(*) from employee
where workinghour >10;

--sum
--sum of room prices higher than 400
select sum(roomprice) from room
where roomprice>400;

--order by, asc
--order hotels by their countries in ascending order
select hotelname, country, city, phone 
from hotel
order by country asc;

--desc
--order employees whose working hours are between 6 and 12, by their working hours in descending order
select name, surname, workinghour
from employee
where workinghour between 6 and 12
order by workinghour desc ;

--group by, having
--list countries which occur in database more than once with their average hotel ratings
select country, avg(rating)
from hotel
group by country
having count(country)>1;

--exists
--rooms that cost more than 500, in hotels that guests stay at
select *
from room r 
where exists (select guestid 
				from guest
				where guest.hotelid =r.hotelid and  r.roomprice>500);

--not exists
--rooms that are not in floors 2 and 3, in hotels guests stay at
select *
from room r 
where not exists (select guestid 
				from guest
				where guest.hotelid =r.hotelid and  (r.floorno=2 or r.floorno=3));
			
--like
--find hotels that have a city matching with ankara
select hotelname, rating, phone
from hotel
where city like 'ankara';

--distinct
--selects distinct guestnames
select distinct g.guestname
from guest g ;

--is null
--find reservation values where reservation date is null
-- we have only 1 nullity in our table so we selected same table for is null and is not null
select *
from reservation r 
where r.reservdate IS NULL;

--is not null
-- find reservation values with reservation dates not null
select *
from reservation r 
where r.reservdate is not NULL;

--in
--find guests whose phone number is either 5309178687 or 5397416478
select guestname, surname
from guest
where phone in ('5309178687','5366503206');

--not in
--find hotels which are in a country neither Turkey nor Germany
select hotelname, country, city, phone
from hotel
where country not in ('türkiye','almanya');

--between and
--hotels which have ratings between 2 and 4
select hotelname,rating
from hotel
where rating between 2 and 4;

--min
--hotel having minimum rating
select min(rating) from hotel;

--max
--Employees having maximum working hours
select max(workinghour) as MaxHour from employee;

--some
--find rooms having a price higher than some of the other rooms
select *
from room r 
where r.roomprice > some(select roomprice 
from room);

--all
--list all hotel names
select all hotelname
from hotel
where true;

--string operations
--find guests whose name starts with "a"
--find guests whose name ends with "a"
--find guests whose name consists of four characters
--find guests who has "a" as a fifth letter in their name
--find guests who has "a" in any position in their name
select guestname,surname from guest g where guestname like 'a%';
select guestname,surname from guest g where guestname like '%a';
select guestname,surname from guest g where guestname like '____';
select guestname,surname from guest g where guestname like '____a';
select guestname,surname from guest g where guestname like '%a%';

--set operations
--union
--find names that are in guests or employees
select guestname from guest
union
select name from employee;

--except
--find names that are in guests but not in employees
select surname from guest
except
select surname from employee;

--intersect
--find names that are in guests and employees
select guestname from guest
intersect
select name from employee;


--Special Queries of Group21---

--Question 1: Top 3 room types which are preferred by customers 

--This query gives the 3 roomtypes that mostly prefferd by guests

select  roomtypeid,Count(roomtypeid) HowManyRooms 
from room
group by roomtypeid
order by count(roomtypeid) desc
limit 3;


--Question 2: Cleaning personnal list which have already used
--their holiday entitlement for current year

--Since we know total holiday entity is 30 First we selected cleaners
--with using subquery than with minus operation we find asked query.

select *
from employee e 
where e.totalholidayent - e.usedholidayent = 0 and 
e.dutyid in ( select dutyid
			from duty d
			where d.dutyname ='cleaningpersonnel');




--Group21 






 





