-- Create a table for users
/* 
First table here holds info on each user.
Zip code uses VARCHAR(10) as data type to account for zip + 4 situations
    and zip codes from other countries that may include letters. */
CREATE TABLE IF NOT EXISTS users (
    user_id INTEGER PRIMARY KEY,
    age INTEGER,
    gender VARCHAR(1),
    occupation VARCHAR(50),
    zip_code VARCHAR(10)
);

/* 
genre columns are 0 if not in genre, 1 if it is.
movies can be in more than one genre.
release_date comment will have to be converted to standard form */
CREATE TABLE IF NOT EXISTS movies (
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    release_date DATE,
    imdb_url TEXT,
    action INT CHECK (action IN (0,1)),
    adventure INT CHECK (adventure IN (0,1)),
    animation INT CHECK (animation IN (0,1)),
    children INT CHECK (children IN (0,1)),
    comedy INT CHECK (comedy IN (0,1)),
    crime INT CHECK (crime IN (0,1)),
    documentary INT CHECK (documentary IN (0,1)),
    drama INT CHECK (drama IN (0,1)),
    fantasy INT CHECK (fantasy IN (0,1)),
    film_noir INT CHECK (film_noir IN (0,1)),
    horror INT CHECK (horror IN (0,1)),
    musical INT CHECK (musical IN (0,1)),
    mystery INT CHECK (mystery IN (0,1)),
    romance INT CHECK (romance IN (0,1)),
    sci_fi INT CHECK (sci_fi IN (0,1)),
    thriller INT CHECK (thriller IN (0,1)),
    war INT CHECK (war IN (0,1)),
    western INT CHECK (western IN (0,1))   
);

/* 
user_id and movie_id connect to the users and movies tables, respectively.
ratings is set to be at least 1 and no more than 5.
I'm using a composite primary key so that I only allow rating per user
 */
 CREATE TABLE IF NOT EXISTS ratings (
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    movie_id INT REFERENCES movies(movie_id) ON DELETE CASCADE,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    timestamp BIGINT,
    PRIMARY KEY (user_id, movie_id)
);

-- In which I realized that I do need that unknown column so that it can track unknown genre
ALTER TABLE movies ADD COLUMN unknown INT CHECK (unknown IN (0,1)) DEFAULT 0;

-- Resettting the movies tables with columns in the preferred order
CREATE TABLE movies_new AS 
SELECT 
    movie_id, title, release_date, imdb_url, unknown, action, adventure, animation, children, 
    comedy, crime, documentary, drama, fantasy, film_noir, horror, musical, mystery, romance,
    sci_fi, thriller, war, western
FROM movies;

-- These stesps were needed because ratings was dependent on movies via foreign key.
DROP TABLE ratings;
DROP TABLE movies;
ALTER TABLE movies_new RENAME TO movies;

--At this point I ran the CREATE ratings query again and began importing.

ALTER TABLE movies ADD PRIMARY KEY (movie_id);

TRUNCATE TABLE movies RESTART IDENTITY CASCADE;

