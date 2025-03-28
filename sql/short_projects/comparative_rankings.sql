/* Using the classic approach, how many movies 
have a rating higher than movie_id = 1.

First find all those films and their averages.
Then take a COUNT of that finding. */
SELECT
    COUNT(*)
    FROM (    
    SELECT
        movie_avgs.movie_id,
        movie_avgs.average
        FROM
            (
                SELECT 
                    movie_id,
                    AVG(rating) average
                FROM ratings
                    GROUP BY movie_id
            ) movie_avgs
        WHERE 
            movie_avgs.average >
            (
                SELECT 
                    AVG(rating)
                FROM ratings
                WHERE movie_id = 1
            )
        ORDER BY movie_avgs.average ASC) c


/* Scores comparison of top 50 titles,
ordered by avg_plus_minus */
/* Here, see how the average plus_minus is affected by
inusfficient ratings on a given movie */
SELECT
    pmr.movie_id,
    pmr.title,
    pmr.avg_plus_minus,
    q.number_of_ratings
    FROM
(SELECT
        ratings_with_user_avg.movie_id AS movie_id,
        movies.title AS title,
        avg(ratings_with_user_avg.plus_minus) AS avg_plus_minus
    FROM
        (
            SELECT 
                a.movie_id,
                a.user_id,
                a.rating,
                b.user_avg,
                a.rating - b.user_avg AS plus_minus
            FROM ratings a JOIN 
                (
                    SELECT 
                        user_id,
                        AVG(rating) as user_avg
                    FROM ratings
                        GROUP BY user_id
                ) b 
                ON a.user_id = b.user_id
        ) ratings_with_user_avg
        JOIN movies on ratings_with_user_avg.movie_id = movies.movie_id
    GROUP BY ratings_with_user_avg.movie_id, movies.title
    ORDER BY avg_plus_minus DESC
) pmr
JOIN
(SELECT
    movie_id,
    COUNT(*) AS number_of_ratings
    FROM ratings
    GROUP BY movie_id
) q
ON pmr.movie_id = q.movie_id
WHERE q.number_of_ratings >= 20
ORDER BY pmr.avg_plus_minus DESC 
    /* Toggle DESC/ASC to find films that 
    were better or worse than expectations  */
    LIMIT 50
