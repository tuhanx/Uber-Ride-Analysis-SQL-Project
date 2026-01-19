-- =============================================
-- 1. DATABASE & TABLE SETUP
-- =============================================

CREATE TABLE ride_bookings (
    ride_date DATE,
    ride_time TIME,
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_status VARCHAR(50),
    vehicle_type VARCHAR(50),
    pickup_location VARCHAR(100),
    drop_location VARCHAR(100),
    avg_vtat DECIMAL(10, 2),
    avg_ctat DECIMAL(10, 2),
    booking_value DECIMAL(10, 2),
    ride_distance DECIMAL(10, 2),
    payment_method VARCHAR(50),
    incomplete_reason VARCHAR(255)
);

time_of_day VARCHAR(20),
    day_name VARCHAR(10),
    month_name VARCHAR(15)
);