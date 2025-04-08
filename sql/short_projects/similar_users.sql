/* 
A simple query finding similar users by just
finding how many connections each user has
with other users. Connections being defined as
instances where a user has given the same rating
to the same movie as another user. Order query by instances of most connections.
  */
SELECT 
    r1.user_id AS user_1,
    r2.user_id AS user_2,
    COUNT(*) AS connections
    FROM ratings r1 JOIN ratings r2 ON r1.rating = r2.rating AND r1.movie_id = r2.movie_id
    WHERE 
        r1.user_id < r2.user_id -- makes sure they are not the same user and prevents dupliates with users in switched spots
    GROUP BY r1.user_id, r2.user_id
    ORDER BY COUNT(*) DESC
    LIMIT 50;

    SELECT 
    movie_id,
    AVG(rating) 
FROM ratings WHERE movie_id IN (1, 2, 3)
GROUP BY movie_id;