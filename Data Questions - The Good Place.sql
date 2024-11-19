/*EXPLORATORY DATA ANALYSIS*/
-- Preview Episodes Data & Data's Shape

SELECT 
    *
FROM
    episode_info
LIMIT 10;

SELECT 
    (SELECT 
            COUNT(*)
        FROM
            episode_info) AS total_episodes,
    (SELECT 
            COUNT(*)
        FROM
            INFORMATION_SCHEMA.COLUMNS
        WHERE
            TABLE_NAME = 'episode_info'
                AND TABLE_SCHEMA = 'the_good_place') AS total_columns;

-- Preview Imdb Data & Data's Shape
SELECT 
    *
FROM
    imdb_info
LIMIT 10;

SELECT 
    (SELECT 
            COUNT(*)
        FROM
            imdb_info) AS total_episodes,
    (SELECT 
            COUNT(*) AS column_count
        FROM
            INFORMATION_SCHEMA.COLUMNS
        WHERE
            TABLE_NAME = 'imdb_info'
                AND TABLE_SCHEMA = 'the_good_place') AS total_columns;
 
-- SUMMARY STATISTICS OVERALL
#Overall Viewership
SELECT 
    COUNT(*) AS total_episodes,
    MIN(us_viewers) AS least_viewed_episode,
    MAX(us_viewers) AS most_viewed_episode,
    MAX(us_viewers) - MIN(us_viewers) AS viewership_range,
    ROUND(AVG(us_viewers)) AS avg_views,
    ROUND(STD(us_viewers)) AS viewers_standard_dev
FROM
    episode_info;

SELECT 
    COUNT(*) AS total_episodes,
    MIN(rating) AS lowest_rated_episode,
    MAX(rating) AS highest_rated_episode,
    MAX(rating) - MIN(rating) AS rating_range,
    ROUND(AVG(rating), 1) AS avg_rating,
    ROUND(STD(rating), 1) AS rating_standard_dev
FROM
    imdb_info;

-- SUMMARY STATS FOR VIEWERSHIP AND RATINGS EACH SEASON 

SELECT 
    season,
    COUNT(*) AS total_episodes,
    MIN(us_viewers) AS least_viewed_episode,
    MAX(us_viewers) AS most_viewed_episode,
    MAX(us_viewers) - MIN(us_viewers) AS viewership_range,
    ROUND(AVG(us_viewers)) AS avg_views,
    ROUND(STD(us_viewers)) AS views_standard_dev
FROM
    episode_info
GROUP BY season
ORDER BY season;


SELECT 
    season,
    COUNT(*) AS total_episodes,
    MIN(rating) AS lowest_rated_episode,
    MAX(rating) AS highest_rated_episode,
    MAX(rating) - MIN(rating) AS rating_range,
    ROUND(AVG(rating), 1) AS avg_rating,
    ROUND(STD(rating), 2) AS rating_standard_dev
FROM
    imdb_info
GROUP BY season
ORDER BY season;


-- 1) What are the 5 most popular episodes?
SELECT 
    episode_info.season, episode_num, episode_info.title, rating
FROM
    episode_info
        JOIN
    imdb_info ON imdb_info.title = episode_info.title
ORDER BY rating DESC , season ASC , episode_num ASC
LIMIT 5;

-- 2) What are the five most viewed episodes?
SELECT 
    episode_info.season,
    episode_num,
    episode_info.title,
    us_viewers
FROM
    episode_info
        JOIN
    imdb_info ON imdb_info.title = episode_info.title
ORDER BY us_viewers DESC , season ASC , episode_num ASC
LIMIT 5;

-- 3) What is the relationship between vieweship and ratings for each episode?
SELECT 
    episode_num_overall,
    episode_info.title,
    us_viewers,
    rating
FROM
    episode_info
        JOIN
    imdb_info ON imdb_info.title = episode_info.title
ORDER BY episode_num_overall;

-- Directors and Writers impacts

-- 4) How many unique Directors have worked on the show? 
SELECT 
    COUNT(DISTINCT directed_by)
FROM
    episode_info;

# Number of episodes directed
-- 5) How many episodes has each director, directed? 
SELECT 
    directed_by, COUNT(*) AS num_episodes_directed
FROM
    episode_info
GROUP BY directed_by
ORDER BY num_episodes_directed DESC;

-- 6) What is the average rating for each Director?  
SELECT 
    directed_by, ROUND(AVG(rating), 2) AS avg_rating
FROM
    episode_info
        JOIN
    imdb_info ON imdb_info.title = episode_info.title
GROUP BY directed_by
ORDER BY avg_rating DESC;


-- 7) How many groups of writers have worked on the show? 
SELECT 
    COUNT(DISTINCT written_by) AS num_of_writing_teams
FROM
    episode_info;

-- 8) How many episodes has each group written? 
SELECT 
    written_by, COUNT(*) AS num_episodes_written
FROM
    episode_info
GROUP BY written_by
ORDER BY num_episodes_written DESC;

-- 9) What is the average rating for each Writing Group?  
SELECT 
    written_by, ROUND(AVG(rating), 2) AS avg_rating
FROM
    episode_info
        JOIN
    imdb_info ON imdb_info.title = episode_info.title
GROUP BY written_by
ORDER BY avg_rating DESC;

-- 10) How many unique pairings of directors and writers have worked on the show? 
SELECT 
    COUNT(DISTINCT directed_by, written_by) AS unique_director_writer_combo
FROM
    episode_info;

-- 11) What are the 10 highest rated episodes, and who directed and wrote them? 
SELECT 
    episode_info.season,
    imdb_info.episode_num,
    episode_info.title,
    episode_info.directed_by,
    episode_info.written_by,
    rating
FROM
    imdb_info
        JOIN
    episode_info ON episode_info.title = imdb_info.title
ORDER BY rating DESC , total_votes DESC
LIMIT 10;

-- 12) What is the average rating for each Director- Writers Group?  
SELECT 
    episode_info.directed_by,
    episode_info.written_by,
    ROUND(AVG(rating), 2) AS avg_dw_rating,
    COUNT(*) AS num_episodes_together
FROM
    imdb_info
        JOIN
    episode_info ON episode_info.title = imdb_info.title
GROUP BY episode_info.directed_by , episode_info.written_by
ORDER BY avg_dw_rating DESC;


/* Viewer Interest Changes*/

-- 13) Across All episodes, what was the percentage change in viewership?
SELECT 
	episode_num_overall, 
    title, 
    us_viewers AS current_episode_viewers, 
    lag(us_viewers) OVER() AS previous_episode_viewers,
	ROUND(((us_viewers-(lag(us_viewers) OVER()))/ lag(us_viewers) OVER())*100,2) AS overall_viewer_pct_change
FROM 
	episode_info
ORDER BY episode_num_overall;

-- 14) Within a season, what was the percentage change in viewership from episode to episode?
SELECT 
	season, 
    episode_num_in_season, 
    title, us_viewers AS current_episode_viewer, 
    lag(us_viewers) OVER(PARTITION BY season ORDER BY season,episode_num_in_season) AS previous_episodes_views,
	round(((us_viewers-(lag(us_viewers) OVER(PARTITION BY season ORDER BY season,episode_num_in_season)))/ lag(us_viewers) OVER(PARTITION BY season ORDER BY season,episode_num_in_season))*100,2)
    AS ep_pct_change_within_season 
FROM 
	episode_info;

-- 15) What is the percentage change in the average viewership, season to season?
SELECT 
	season, 
	AVG(us_viewers) AS current_season_avg_viewers, 
	LAG(AVG(us_viewers)) OVER() AS previous_season_avg_viewers,
	ROUND(((AVG(us_viewers)-LAG(AVG(us_viewers))OVER())/LAG(AVG(us_viewers)) OVER())*100,2) AS season_viewer_pct_change
FROM 
	episode_info
GROUP BY season;


/* Audience Satisfaction*/

-- 16) Across All episodes, what was the percentage change in ratings?
SELECT 
    episode_num_overall, 
    episode_info.title, 
    rating AS current_episode_rating,
	lag(rating) OVER() AS previous_episode_rating, 
	round(((rating - lag(rating) OVER()) / lag(rating) OVER()) * 100,2) AS ep_rating_pct_change
FROM 
	episode_info
JOIN imdb_info
ON imdb_info.title = episode_info.title
ORDER BY episode_num_overall;

-- 17) Within a season, what was the percentage change in ratings from episode to episode?
SELECT 
	episode_info.season, 
    episode_num_in_season, 
    episode_info.title, 
    rating AS current_rating, 
    lag(rating) OVER(PARTITION BY season ORDER BY season,episode_num_in_season) AS previous_rating, 
	ROUND(((rating - lag(rating) OVER(PARTITION BY season ORDER BY season,episode_num_in_season)) / lag(rating) OVER(PARTITION BY season ORDER BY season,episode_num_in_season)) * 100,2)
	AS ep_pct_change_within_season
FROM 
	episode_info
JOIN imdb_info
ON imdb_info.title = episode_info.title;

-- 18) What is the percentage change in the average rating, season to season?
SELECT 
	season, 
    avg(rating) AS current_season_avg_rating, 
    lag(avg(rating)) OVER() AS previous_season_avg_rating,
	round(((avg(rating) -  lag(avg(rating)) OVER()) /  lag(avg(rating)) OVER()) * 100,2) AS season_avg_pct_change
FROM 
	imdb_info
GROUP BY season;










