SELECT 
        ratings.movie_id,
        title,
        AVG(rating) 
    FROM ratings JOIN movies ON 
        ratings.movie_id = movies.movie_id
    WHERE ratings.movie_id IN (1,2,3)
    GROUP BY ratings.movie_id, movies.title
    ORDER BY AVG(rating) DESC

 LIMIT 5
/* SELECT * FROM movies m Limit 1 */