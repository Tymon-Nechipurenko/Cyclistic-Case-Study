LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Cyclistic Data 2023\\202305-divvy-tripdata.csv' 
INTO TABLE google_analytics_capstone.may_23 
FIELDS TERMINATED BY ',' 
IGNORE 1 LINES
(@ride_id, @rideable_type, @started_at, @ended_at, @start_station_name, @start_station_id, @end_station_name, @end_station_id, @start_lat, @start_lng, @end_lat, @end_lng, @member_casual, @ride_length, @weekday, @month)
SET ride_id = @ride_id,
    rideable_type = @rideable_type,
    started_at = STR_TO_DATE(@started_at, '%m/%d/%Y %H:%i'),
    ended_at = STR_TO_DATE(@ended_at, '%m/%d/%Y %H:%i'),
    start_station_name = @start_station_name,
    start_station_id = @start_station_id,
    end_station_name = @end_station_name,
    end_station_id = @end_station_id,
    start_lat = @start_lat,
    start_lng = @start_lng,
    end_lat = @end_lat,
    end_lng = @end_lng,
    member_casual = @member_casual,
    ride_length = @ride_length,
    weekday = @weekday,
    month = @month;

