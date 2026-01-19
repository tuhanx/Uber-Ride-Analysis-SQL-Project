-- --------------------------------------------------------
-- 1. GENERIC & OPERATIONAL ANALYSIS
-- --------------------------------------------------------

-- Q1: What is the breakdown of booking statuses?
select
    booking_status,
    count(*) as total_rides,
    round(count(*) * 100.0 / (select count(*) from ride_bookings), 2) as percentage
from ride_bookings
group by booking_status
order by total_rides desc;
-- Q2: What are the top reasons for incomplete rides?
select
    incomplete_reason,
    count(*) as total_count,
    round(count(*) * 100.0 / (select count(*) from ride_bookings where booking_status = 'Incomplete'), 2) as percentage
from ride_bookings
where booking_status= 'Incomplete'
group by incomplete_reason
order by total_count desc
limit 5;

-- Q3: Which day of the week has the highest booking volume?
select
    day_name,
    count(*) as total_rides
from ride_bookings
group by day_name
order by total_rides desc;

-- --------------------------------------------------------
-- 2. PRODUCT (VEHICLE) ANALYSIS
-- --------------------------------------------------------

-- Q1: Top 5 Vehicle Types by Volume & Revenue
select
    vehicle_type,
    count(*) as total_rides,
    sum(booking_value) as total_revenue,
    round(sum(booking_value) * 100.0 / (select sum(booking_value) from ride_bookings), 2) as revenue_share
from ride_bookings
where booking_status = 'Completed'
group by vehicle_type
order by total_revenue desc
limit 5;

-- Q2: Average Fare & Distance by Vehicle Type
select
    vehicle_type,
    round(avg(booking_value), 2) as avg_fare,
    round(avg(ride_distance), 2) as avg_distance,
    round(avg(booking_value) / avg(ride_distance), 2) as price_per_km
from ride_bookings
where booking_status = 'Completed'
group by vehicle_type
order by avg_fare desc;

-- --------------------------------------------------------
-- 3. TIME ANALYSIS
-- --------------------------------------------------------

-- Q1: Total Rides by Time of Day
select
    time_of_day,
    count(*) as total_rides,
    round(count(*) * 100.0 / (select count(*) from ride_bookings), 2) as percantage
from ride_bookings
group by time_of_day
order by total_rides desc;

-- Q2: Average Booking Value by Time of Day
select
    time_of_day, round(avg(booking_value), 2) as avg_fare
from ride_bookings
group by time_of_day
order by avg_fare desc;

-- --------------------------------------------------------
-- 4. SALES (REVENUE) ANALYSIS
-- --------------------------------------------------------

-- Q1: Revenue by Payment Method
select
    payment_method, sum(booking_value) as total_revenue, count(*) as total_rides, round(sum(booking_value) * 100.0 / (select sum(booking_value) from ride_bookings), 2) as revenue_share
from ride_bookings
where booking_status = 'Completed'
group by payment_method
order by total_revenue desc;

-- Q2: Revenue Loss Analysis (Est. Loss due to Cancellations)
select
    booking_status,
    count(*) as lost_rides_count,
    round(count(*) * (select avg(booking_value) from ride_bookings where booking_status = 'Completed'), 2) as estimated_loss_amount
from ride_bookings
where booking_status != 'Completed' -- Başarısız sürüşler
group by booking_status
order by estimated_loss_amount;

-- Q3: Top Earners (Highest Revenue Locations)
select
    pickup_location,
    sum(booking_value) as total_revenue,
    count(*) as ride_count
from ride_bookings
where booking_status = 'Completed'
group by pickup_location
order by total_revenue desc
limit 10;

-- --------------------------------------------------------
-- 5. ROUTE & EFFICIENCY ANALYSIS
-- --------------------------------------------------------

-- Q1: Top 5 Routes (Pickup -> Dropoff Combination)
select
    pickup_location,
    drop_location,
    count(*) as total_rides
from ride_bookings
group by pickup_location, drop_location
order by total_rides desc
limit 5;

-- Q2: Average Pickup Time by Vehicle Type (VTAT Analysis)
select
    vehicle_type,
    round(avg(avg_vtat), 2) as avg_pickup_time_minutes
from ride_bookings
group by vehicle_type
order by avg_pickup_time_minutes asc;