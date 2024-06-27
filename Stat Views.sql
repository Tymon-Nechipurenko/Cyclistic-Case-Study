
CREATE VIEW stats_by_month AS 

SELECT
TRIM(REPLACE(month, '\r', '')) AS months,
	-- rideable_type,
	-- member_casual,
SUM(minute(ride_length)) as minutes_ridden,
AVG(minute(ride_length)) as avg_ride_length_min,
COUNT(DISTINCT ride_id) as num_of_riders

FROM cyclistic_23

GROUP BY months
    
ORDER BY minutes_ridden DESC ;



CREATE VIEW stats_by_bike_type AS 

SELECT
-- TRIM(REPLACE(month, '\r', '')) AS months,
rideable_type,
	-- member_casual,
SUM(minute(ride_length)) as minutes_ridden,
AVG(minute(ride_length)) as avg_ride_length_min,
COUNT(DISTINCT ride_id) as num_of_riders

FROM cyclistic_23

GROUP BY rideable_type
    
ORDER BY minutes_ridden DESC ;


CREATE VIEW stats_by_membership AS 

SELECT
-- TRIM(REPLACE(month, '\r', '')) AS months,
-- rideable_type,
member_casual,
SUM(minute(ride_length)) as minutes_ridden,
AVG(minute(ride_length)) as avg_ride_length_min,
COUNT(DISTINCT ride_id) as num_of_riders

FROM cyclistic_23

GROUP BY member_casual
    
ORDER BY minutes_ridden DESC 