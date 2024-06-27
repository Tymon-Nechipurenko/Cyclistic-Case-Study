### Project Overview:
- Cyclistic is a bikesharing company in Chicago.
- Current business structure based on single ride passes, single day passes and annual memberships.
- Company wants to convert casual riders (single ride and single day passes) to members.
- Head of Marketing assigns me as an analyst to understand Cyclistic users for business decision making.

### Guiding questions for case study:
 1. How do annual members and casual riders use Cyclistic bikes differently?
 2. Why would casual riders buy Cyclistic annual memberships?
 3. How can Cyclistic use digital media to influence casual riders to become members?

### Files Included:
- Case Study prompt.
- SQL code for creating tables, importing data, creating views and convienient queries.
- Images of Dashboards created in Tableau using aggregated data from MySQL.
- PowerPoint Presentation for the case study.

### Tableau Public Dashboard: https://public.tableau.com/views/CyclisticAggregateDashboard/Dashboard1?:language=en-US&:sid=&:display_count=n&:origin=viz_share_link

### Tools Used:
- Excel
- PowerQuery
- MySQL
- Tableau
- PowerPoint

### Excel Data Cleaning/Preperation :
- Removed rows with blank columns due to volme of files (all over 30mb)
- Formatted data types
- Created calculated fields such as ride length
- Converted dates to specfiy weekdays and months in new columns

### Power Query application:
- Due to size of datasets, used Power Query to create Power Pivot tables for macro overview of dataset (primairly to understand ride count volume by month).
- File size too large to upload to GitHub, as well as too large for Tableau Public to function properly, so used SQL to sample data for statistical signficance.

### SQL Code:
- Table Creation:

```sql
USE google_analytics_capstone ;

 CREATE TABLE jan_23 (
	ride_id VARCHAR (50),
	rideable_type VARCHAR (20),
	started_at DATETIME,
	ended_at DATETIME,
	start_station_name VARCHAR (50),
	start_station_id VARCHAR (50),
	end_station_name VARCHAR (50),
	end_station_id VARCHAR (50),
	start_lat DOUBLE,
	start_lng DOUBLE,
	end_lat DOUBLE,
	end_lng DOUBLE, 
	member_casual VARCHAR (20),
	ride_length TIME,
	weekday VARCHAR (20),
    month VARCHAR (20)
);
```

- Loading Data:
```sql
-- Did this for every month's CSV file. started_at/ended_at required reformatting in date format.

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
```

- Combining Data:
```sql
-- Figuring out sample size for accurate analysis in order to condense data into usable memory size for tableau public upload (<1 GB)

SELECT 
    COUNT(*)
FROM
    dec_23;

-- jan 150338
-- feb 151809
-- mar 202710
-- apr 324197
-- may 471463
-- june 534758
-- july 573958
-- august 584920
-- september 516056
-- oct 412578
-- nov 280689
-- dec 167143

-- total = 4,495,100

-- for 95% CI with a population N of ~5 Million, a sample n of 360,000 (30k per month) would produce a margin of error of +/- .163%


CREATE TABLE cyclistic_23 AS 

(SELECT * FROM jan_23 LIMIT 30000)

UNION 

(SELECT * FROM feb_23 LIMIT 30000)

UNION 

(SELECT * FROM mar_23 LIMIT 30000)

UNION 

(SELECT * FROM apr_23 LIMIT 30000)

UNION 

(SELECT * FROM  may_23 LIMIT 30000)

UNION 

(SELECT * FROM jun_23 LIMIT 30000)

UNION 

(SELECT * FROM jul_23 LIMIT 30000)

UNION 

(SELECT * FROM aug_23 LIMIT 30000)

UNION 

(SELECT * FROM sep_23 LIMIT 30000)

UNION 

(SELECT * FROM oct_23 LIMIT 30000)

UNION 

(SELECT * FROM nov_23 LIMIT 30000)

UNION 

(SELECT * FROM dec_23 LIMIT 30000)

```

- Views Created (grouping months required cleaning whitespace):
```sql

CREATE VIEW stats_by_month AS 

SELECT
member_casual,
TRIM(REPLACE(month, '\r', '')) AS months,
	-- rideable_type,

SUM(minute(ride_length)) as minutes_ridden,
AVG(minute(ride_length)) as avg_ride_length_min,
COUNT(DISTINCT ride_id) as num_of_riders

FROM cyclistic_23

GROUP BY member_casual, months
    
ORDER BY minutes_ridden DESC ;

-------------------------------------------------------

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

-------------------------------------------------------------

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

```

- Queries for finding Top 10 Starting Stations by membership type:

```sql
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
```
### Tableau:
- Used Tableau Public to create multiple interactive dashboards answering questions such as:
  - Where are they riding?
  - What time are they riding?
  - What days are they riding?
  - What bikes are they riding?



## Conclusions:

### Why would casual riders buy annual memberships?
- Casual Riders, though at lower rates, bike year-round and could benefit from annual rates.
- Casual Riders appear to use bikesharing more recreationally on weekends around coastal stations. Memberships offer more convenience for spontaneous weekend trips along the waterfront.
- Casual riders, like members, most often ride around 5-6pm after working hours during warmer months. Memberships allow more efficient ease of access to bikes for evening activities.
  
### How can Cyclistic use digital media to influence casual riders into buying memberships?

- Target advertisements toward users at coastal starting stations.
- User increase highly correlated with temperature and the seasons. For maximum reach, marketing campaigns should occur in Spring and Summer.
- Casual riders notably have higher rates of using e-bikes during the Spring. Incorporate e-bikes specifically in Spring marketing campaigns. 
- Casual riders are more likely to be recreational users in the evening, so emphasize the convenience of not having to pay microtransactions to access bikes during their relaxation time. 
- Offer discounts and present benefits of annual memberships on weekends when casual riders are most likely to use Cyclistic’s services.


### Further Recommendations: 
- Need more data on consumers such as user’s gender, age, demographic and address to get a better understand of who’s using Cyclistic as to inform marketing strategy.
- Further insight into pricing models as to offer a more comprehensive understanding regarding the benefits of memberships over single use/full day passes
- More granularity in what makes up the casual rider category. Segmenting between single use and full day pass users would allow more accuracy in tracking behaviors for targeted marketing purposes. 









