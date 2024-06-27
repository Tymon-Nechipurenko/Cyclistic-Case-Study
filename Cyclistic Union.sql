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

