import zipfile
import os

# Path to your downloaded ZIP file
zip_path = "movielens-100k-dataset.zip"  # file name
extract_folder = "Projects"  # Folder to extract files into

# Extract the ZIP file
with zipfile.ZipFile(zip_path, 'r') as zip_ref:
    zip_ref.extractall(extract_folder)

print(f"Files extracted to: {os.path.abspath(extract_folder)}")

