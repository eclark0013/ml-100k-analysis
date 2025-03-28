import pandas as pd
from datetime import datetime

# Load the movies data
file_path = "/Users/ericclark/Desktop/DataScience/Projects/relatively/ml-100k/u.item"
output_file = "/Users/ericclark/Desktop/DataScience/Projects/relatively/ml-100k/u.item.cleaned"

# Define column names
columns = [
    "movie_id", "title", "release_date", "video_release_date", "imdb_url",
    "unknown", "action", "adventure", "animation", "children", "comedy",
    "crime", "documentary", "drama", "fantasy", "film_noir", "horror",
    "musical", "mystery", "romance", "sci_fi", "thriller", "war", "western"
]

# Read the file
df = pd.read_csv(file_path, sep="|", names=columns, encoding="latin-1")

# Convert the release_date format
df["release_date"] = pd.to_datetime(df["release_date"], format="%d-%b-%Y", errors="coerce").dt.strftime("%Y-%m-%d")

# Save cleaned data
df.to_csv(output_file, sep="|", index=False, header=False)