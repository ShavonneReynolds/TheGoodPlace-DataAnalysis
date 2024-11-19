USE the_good_place;
/*  DATA CLEANING
*/

SELECT * FROM episode_info;
SELECT * FROM imdb_info;
DESC episode_info;
DESC imdb_info;

-- REMOVE DUPLICATES

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY season,episode_num_in_season,episode_num_overall,title) AS row_num
FROM episode_info;

WITH duplicate_cte AS (
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY season,episode_num_in_season,episode_num_overall,title) AS row_num
FROM episode_info
)
SELECT * FROM duplicate_cte
WHERE row_num > 1;
#No duplicates found in episode table

#IMDB TABLE
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY season, episode_num,title, 'desc') AS row_num
FROM imdb_info;

WITH duplicate_cte AS (
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY season, episode_num,title, 'desc') AS row_num
FROM imdb_info
)
SELECT * FROM duplicate_cte
WHERE row_num > 1;
#No duplicates found in imdb table

-- STANDARDIZE THE DATA
SELECT COUNT(*) 
FROM episode_info;

SELECT DISTINCT season,episode_num_in_season,title
FROM episode_info;

SELECT DISTINCT season, episode_num, title 
FROM imdb_info;
#There are some episodes that were split into two parts but are referred to as one in the imdb ratings

#Change seasons column name in both tables
ALTER TABLE episode_info
RENAME COLUMN ï»¿season to season;

ALTER TABLE imdb_info
RENAME COLUMN ï»¿season to season;

#Convert original_air_date to date format rather than timestamp
ALTER TABLE episode_info
CHANGE original_air_date og_date DATE;

ALTER TABLE imdb_info
CHANGE original_air_date og_date DATE;

#Convert ratings to a decimal
ALTER TABLE imdb_info
CHANGE imdb_rating rating DECIMAL(2,1);

-- NULL VALUES AND BLANK VALUES
SELECT *
FROM episode_info
WHERE title IS NULL
OR title = '';

SELECT *
FROM episode_info
WHERE written_by IS NULL
OR written_by= '';
#No null values exist in the episodes table

SELECT *
FROM imdb_info
WHERE title IS NULL
OR title = '';

SELECT *
FROM imdb_info
WHERE imdb_rating IS NULL
OR imdb_rating = '';

SELECT *
FROM imdb_info
WHERE 'desc' IS NULL
OR 'desc' = '';
#No null values in the imdb table

#NULL Values found when right join is used because the part 2 of the episodes were released as a single episode; therefore, therefore, the ratings will be the same and the 
SELECT episode_info.title, episode_info.directed_by, episode_info.written_by, rating
FROM imdb_info
RIGHT JOIN episode_info 
ON episode_info.title = imdb_info.title
WHERE rating IS NULL 
OR rating = '';

SELECT episode_info.title, episode_info.directed_by, episode_info.written_by, rating
FROM imdb_info
RIGHT JOIN episode_info 
ON episode_info.title = imdb_info.title;

SELECT * 
FROM episode_info
WHERE title 
LIKE '%PART 2';

SELECT * 
FROM imdb_info
WHERE title
LIKE 'Everything Is%';

INSERT INTO imdb_info(season,episode_num,title,og_date,rating,total_votes,`desc`)
VALUES (2,1,'Everything Is Great! Part 2','2017-09-20',8.6,2798,'After Michael erases their memories, Eleanor, Chidi, Tahani and Jason find themselves in the Good Place again, but Eleanor finds a clue she left for herself and tries to put everything together.'),
	   (3,1,'Everything Is Bonzer! Part 2','2018-09-27',8.2,2314,'Michael prevents the deaths of Eleanor, Chidi, Tahani and Jason, hoping a second chance at life will allow them to become better people.');

-- COLUMN REMOVAL
SELECT *
FROM episode_info;

SELECT * 
FROM imdb_info
ORDER BY season,episode_num;

#No column will be removed, all of them are significant to the analysis
