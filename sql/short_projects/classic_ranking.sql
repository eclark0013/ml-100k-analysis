/* Classic approach for ranking movies. Find 
the average score and list them by average, descending. */
SELECT
        title,
        ratings.movie_id,
        AVG(rating)
        FROM movies JOIN ratings ON 
            movies.movie_id = ratings.movie_id
        GROUP BY ratings.movie_id, title
        ORDER BY AVG(rating) DESC

/* See how many ratings each movie has */
SELECT
    movie_id,
    COUNT(*) AS number_of_ratings
    FROM ratings
    GROUP BY movie_id

/* See how many ratings are given for each film
in the top 20 given the classical approach. */
SELECT
    cr.title,
    cr.movie_id,
    cr.average_rating,
    q.number_of_ratings 
    FROM
    (SELECT
        title,
        ratings.movie_id,
        AVG(rating) AS average_rating
        FROM movies JOIN ratings ON 
            movies.movie_id = ratings.movie_id
        GROUP BY ratings.movie_id, title
        ORDER BY AVG(rating) DESC
    ) cr
    JOIN 
    (SELECT
        movie_id,
        COUNT(*) AS number_of_ratings
        FROM ratings
        GROUP BY movie_id
    ) q
    ON cr.movie_id = q.movie_id
    WHERE q.number_of_ratings >= 20
    ORDER BY cr.average_rating DESC 
    /* Toggle DESC/ASC to find films that 
    have lower or higher average */
    LIMIT 20
/* As suspected, the top 15 movies
all have a number_of_ratings less than 5. Trying
now for movies with at least 10 rankings. */
