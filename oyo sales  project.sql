create database oyo;
use oyo;


select * from oyo_sales;
select * from oyo_city;
set sql_safe_updates=0;
rename table s to oyo_sales;

alter table oyo_sales add price  float null;
update oyo_sales set price=amount+discount;
alter table oyo_sales add rate float null;
alter table oyo_sales add no_of_nights int null;
update oyo_sales set no_of_nights=datediff(check_out,check_in);
update oyo_sales set rate=round(case when no_of_rooms=1 then price/no_of_nights else price/no_of_nights/no_of_rooms end,2);
select * from oyo_sales;
#no_of _hotels
select count(*) from oyo_city;
#No.of cities
select count(distinct city) as total_city from oyo_city;
#no. of records
select count(*)as total_records from oyo_sales;
select * from oyo_sales;

-- No. of hotels in different cities
select city ,count(hotel_id)as no_of_hotels from oyo_city group by city order by no_of_hotels desc ;
-- What is the average room rates in different cities
select oyo_city.city,round(avg(rate),2)as average_rates from sales_oyo join oyo_city using(hotel_id)group by city order by average_rates desc limit 5 ;

-- WHAT IS THE % CANCELLATION RATES--  
select city ,(sum(case when  status='cancelled' then 1 else 0 end)/count(date_of_booking)*100)as cancellation_rate from oyo_sales inner join oyo_city using(hotel_id)
group by city order by cancellation_rate desc limit 5;

-- No. OF BOOKING IN DIFFERENT CITIIES IN JAN,FEB,MARCH MONTHS-- 
select city, month(date_of_booking)as months ,count(booking_id)as total_booking from oyo_sales inner join oyo_city using(hotel_id) group by city,months order by 1,2;
select * from s;
-- FREQUENCY OF EARLY BOOKING PRIOR TO CHECK-IN HOTEL--  
select datediff(check_in,date_of_booking)as days_before_check_in,count(booking_id)as booking_room from s group by days_before_check_in ;

-- NET REVENUE AND GROSS REVENEUE TO COMPANY --  
select  city,sum(amount)as gross_revenue,sum(case when status in ('stayed', 'no show') then  amount end)as net_revenue from oyo_sales inner join 
oyo_city using(hotel_id)
group by city  order by city;

-- FREQUENCY OF BOOKING OF NO. OF ROOMS IN HOTEL--
select no_of_rooms,(count(booking_id)) from oyo_sales group by no_of_rooms;  
select * from oyo_sales;
-- DISCOUNT OFFERED BY DIFFERENT CITIES--
select city,round(avg(100*discount/price),1)as discount_offered from oyo_sales inner join oyo_city using(hotel_id) group by city order by discount_offered desc;  
