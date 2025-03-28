/* For each user, find the highest rated movie that they
haven't watched yet of their favorite genre.

1. Find the genre that a given user has watched the
most of.
 - make sure user has at least 20 ratings

2. Find the top ranked movies of that genre.

3. Find movies of that genre that the user has not yet watched.

*/
SELECT
    CASE
        WHEN m.unknown THEN 

SELECT * FROM movies
LIMIT 10