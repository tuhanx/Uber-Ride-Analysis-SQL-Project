-- =============================================
-- 2. ETL (EXTRACT, TRANSFORM, LOAD) & FEATURE ENGINEERING
-- =============================================

INSERT OR IGNORE INTO ride_bookings (
    ride_date, ride_time, booking_id, booking_status, vehicle_type,
    pickup_location, drop_location, avg_vtat, avg_ctat,
    booking_value, ride_distance, payment_method, incomplete_reason
)
SELECT

    c1,
    c2,
    c3,
    c4,
    c6,
    c7,
    c8,
    CAST(NULLIF(c9, 'nan') AS DECIMAL(10,2)),
    CAST(NULLIF(c10, 'nan') AS DECIMAL(10,2)),
    CAST(NULLIF(c17, 'nan') AS DECIMAL(10,2)),
    CAST(NULLIF(c18, 'nan') AS DECIMAL(10,2)),
    c21,
    C16
FROM ride_bookings_raw
WHERE c1 <> 'Date';

------------------- Feature Engineering -----------------------------
1. Time_of_day

alter table ride_bookings add column time_of_day varchar(20);

update ride_bookings
set time_of_day=(
    case
        when ride_time >= '06:00:00' and ride_time < '12:00:00' then 'Morning'
        when ride_time >= '12:00:00' and ride_time < '17:00:00' then 'Afternoon'
        when ride_time >= '17:00:00' and ride_time < '21:00:00' then 'Evening'
        else 'Night'
    end
);

2. Day_name

alter table ride_bookings add column day_name varchar(10);

update ride_bookings
set day_name= (
    case strftime('%w', ride_date)
    when '0' then 'Sunday'
    when '1' then 'Monday'
    when '2' then 'Tuesday'
    when '3' then 'Wednesday'
    when '4' then 'Thursday'
    when '5' then 'Friday'
    when '6' then 'Saturday'
    end);

3. Month_name

select distinct strftime('%m', ride_date) from ride_bookings;

ALTER TABLE ride_bookings ADD COLUMN month_name VARCHAR(15);

update ride_bookings
set month_name = (
    case SUBSTR(ride_date, 6, 2)
        when '01' then 'January'
        when '02' then 'February'
        when '03' then 'March'
        when '04' then 'April'
        when '05' then 'May'
        when '06' then 'June'
        when '07' then 'July'
        when '08' then 'August'
        when '09' then 'September'
        when '10' then 'October'
        when '11' then 'November'
        when '12' then 'December'
        else 'Unknown'
    END
);

