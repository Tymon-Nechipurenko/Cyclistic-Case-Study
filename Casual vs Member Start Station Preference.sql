SELECT
start_station_name,
COUNT(DISTINCT ride_id) num_of_rides

FROM cyclistic_23

WHERE member_casual = 'casual' 

GROUP BY start_station_name 

ORDER BY num_of_rides DESC 

LIMIT 10;

-- Focus on causual riders who go to Streeter Dr & Grand Ave, Millennium Park, Wells St & Concord Ln, DuSable Lake Shore Dr & Monroe St, and Wells St & Hubbard St

SELECT
start_station_name,
COUNT(DISTINCT ride_id) num_of_rides

FROM cyclistic_23

WHERE member_casual = 'member' 

GROUP BY start_station_name 

ORDER BY num_of_rides DESC 

LIMIT 10;