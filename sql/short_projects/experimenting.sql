/* Of those that are ranked highest in the classic rating
 system, how many may have a high average due to so few 
 rankings for that film. Do I need a bigger data set?
 
 First, see how many ratings does each film have on average.*/

-- SELECT
--     movie_id,
--     COUNT(*) AS number_of_ratings
--     FROM ratings
--     GROUP BY movie_id

-- SELECT movies.movie_id, movies.title, AVG(rating) FROM 
--     ratings JOIN movies ON ratings.movie_id 
--                         = movies.movie_id
--     where ratings.movie_id IN (814, 1536, 1467, 1500, 1599, 1642, 1653, 1293, 1449, 1398, 1650)
--     GROUP BY movies.movie_id, movies.title

-- SELECT * FROM ratings
--     WHERE movie_id IN (814, 1536, 1467, 1500, 1599, 1642, 1653, 1293, 1449, 1398, 1650)
--     ORDER BY movie_id, rating DESC

-- SELECT * FROM ratings
--     WHERE user_id = 707
--     ORDER BY rating DESC

SELECT DISTINCT user_id, COUNT(*) FROM ratings GROUP BY user_id HAVING COUNT(*) < 30 ORDER BY COUNT(*)

-- SELECT * FROM ratings WHERE user_id = 33

