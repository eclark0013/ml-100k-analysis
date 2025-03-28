/* GOAL: Among the users who give the lowest scores,
which films do they like best. */

/* Finding the 50 users with the lowest 
average rating */
SELECT 
    u.user_id,
    COUNT(r.rating),
    AVG(r.rating)
    FROM users u JOIN ratings r ON
        u.user_id = r.user_id
        GROUP BY 
        u.user_id, r.user_id
        ORDER BY
        AVG(r.rating) 
    LIMIT 50

/* How many ratings is this? 5589*/
SELECT
    SUM(a.ratings_count)
    FROM
    (SELECT 
    u.user_id,
    COUNT(r.rating) AS ratings_count,
    AVG(r.rating)
    FROM users u JOIN ratings r ON
        u.user_id = r.user_id
        GROUP BY 
        u.user_id, r.user_id
        ORDER BY
        AVG(r.rating) 
    LIMIT 50) a

/* Among the 50 pickiest, which movies do they like best */
    SELECT
    r.movie_id,
    m.title,
    AVG(r.rating),
    COUNT(r.rating)
    FROM
    ratings r RIGHT JOIN 
        (SELECT 
            u.user_id,
            COUNT(r.rating),
            AVG(r.rating)
            FROM users u JOIN ratings r ON
                u.user_id = r.user_id
                GROUP BY 
                u.user_id, r.user_id
                ORDER BY
                AVG(r.rating) 
            LIMIT 50) choosy_users
        ON r.user_id = choosy_users.user_id
        JOIN movies m ON r.movie_id = m.movie_id
    GROUP BY r.movie_id, m.title
    HAVING COUNT(r.rating) >= 5
    ORDER BY AVG(r.rating) DESC