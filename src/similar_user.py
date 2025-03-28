""" 
Goal:
For a given user (SUBJECT): 
    For each other user:
        Fetch the ratings corresponding to movies that they and SUBJECT both rated (co-rated)
        Loop over those movies to find the ones they gave the same rating (equal-rated)
        Give their compatability with SUBJECT as a percentage of (equal-rated/co-rated)
        Find the user with highest compatability score for SUBJECT
"""
import pandas as pd
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

def similar_user(subject_id):
    # Get a list of all users that have given a rating and are not SUBJECT
    cur.execute("SELECT DISTINCT user_id FROM ratings WHERE user_id != 1 ORDER BY user_id;")
    user_ids = [row[0] for row in cur.fetchall()]

    # Create an empty list to store results
    data = []

    # Loop through each user and fetch the movie_id's where they both gave a rating (corated)
    for user_id in user_ids:
        cur.execute(""" 
        SELECT 
            r1.movie_id,
            r1.rating,
            r2.rating                 
            FROM ratings r1 JOIN ratings r2 ON r1.movie_id = r2.movie_id
            WHERE r1.user_id = %s 
                AND r2.user_id != %s
                AND r2.user_id = %s;                
        """, (subject_id, subject_id, user_id)) 
        query_results = cur.fetchall()

        corated_movie_ids = [row[0] for row in query_results]
        corated_count = len(corated_movie_ids)
        
        
        if corated_count > 0: # prevents division by 0 error
            equalrated_ids = []

            for row in query_results:
                if row[1] == row[2]:
                    equalrated_ids.append(row[0])
            
            equalrated_count = len(equalrated_ids)

            compatibility = round((equalrated_count/corated_count)*100, 2)

            data.append((user_id, compatibility, corated_count, corated_movie_ids, equalrated_count, equalrated_ids))

    # Run SQL query and store result in a DataFrame
    # query = "SELECT DISTINCT user_id, AVG(rating) FROM ratings GROUP BY user_id LIMIT 5;"
    # df = pd.read_sql(query, conn)

    df = pd.DataFrame(data, columns=["user_id", "compatibility", "corated_count", "corated_movies", "equalrated_count", "equalrated_ids"])

    # Sort the data frame by number of corated movies to remove compability that is occuring just due to insignificantly few corated movies
    df_corate_sorted = df.sort_values(by="corated_count", ascending=False)

    # Cut off everything other than the first 500 users
    df_corate_cut = df_corate_sorted.head(500)

    # Sort the data by compatibility
    df_compatibilty_sorted = df_corate_cut.sort_values(by="compatibility", ascending=False)

    df_compatibility_cut = df_compatibilty_sorted.head(10)

    # Display the table
    print(df_compatibility_cut)

    if not df_compatibility_cut.empty:
        most_similar_user = df_compatibility_cut.iloc[0]
        print(f"Most similar user is user number {most_similar_user["user_id"]} with a compatibility percentage of {most_similar_user["compatibility"]}%.")
        return int(most_similar_user["user_id"])
    else:
        print("No similar users")
        return None

similar_user(848)

# Close the connection
cur.close()
conn.close()