

/* 
Defining plus minus differential (plus_minus) as 
the average difference in rating between the user's 
rating on this film and the user's average rating. 

Here I find the plus_minus of movie_id = 1
by averaging all the plus_minus scores for that movie */
SELECT
        AVG(ratings_with_user_avg.plus_minus)
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
                WHERE movie_id=1
        ) ratings_with_user_avg


/* Here I find the average plus_minus of each movie */
SELECT
        ratings_with_user_avg.movie_id,
        movies.title,
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
