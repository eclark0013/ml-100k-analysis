import pandas as pd
import os

# Define the folder where data is extracted
extract_folder = "data/raw/ml-100k"

# List all files in the folder
print("Files in dataset folder:", os.listdir(extract_folder))

# Path to CSV file (adjust filename if needed)
movies_path = os.path.join(extract_folder, "u.data")

# Load dataset
df = pd.read_csv(movies_path, sep="\t")

# Display first few rows
print(df.head())

print(df.info())    # Get column details
print(df.describe())  # Summary statistics
print(df.columns)  # List column names