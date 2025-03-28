from dotenv import load_dotenv
import os
import psycopg2

# Load .env file
load_dotenv()

# Get database credentials from environment variables
conn = psycopg2.connect(
    dbname=os.getenv("DB_NAME"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD"),
    host=os.getenv("DB_HOST"),
    port=os.getenv("DB_PORT")
)

cur = conn.cursor()
cur.execute("SELECT movie_id, title, unknown, action, adventure, animation, children,  "
"comedy, crime, documentary, drama, fantasy, film_noir, horror, musical, "
"mystery, romance, sci_fi, thriller, war, western "
"FROM movies LIMIT 10;")
rows = cur.fetchall()

# Genre names to match column names with 1s
genre_names = [
    "Unknown", "Action", "Adventure", "Animation", "Children", "Comedy", "Crime", "Documentary", "Drama", 
    "Fantasy", "Film Noir", "Horror", "Musical", "Mystery", "Romance", "Sci-Fi", "Thriller", 
    "War", "Western"
]

for row in rows:
    movie_id = row[0]
    movie_title = row[1]
    movie_genres = []
    for i, genre in enumerate(row[2:]):  # Start from index 2 to skip the movie_id and title
        if genre == 1:  # Check if the genre value is 1
            movie_genres.append(genre_names[i])  # Append genre name 
    print (f"Movie ID: {movie_id}, titled: {movie_title} belongs to genres {movie_genres}")


cur.close()
conn.close()
