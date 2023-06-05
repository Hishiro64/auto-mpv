import requests
import json
import os
import re
import sys

# Set the URL for the Jellyfin
url = sys.argv[1]

# Set the API
api_key = sys.argv[2]

# Set the headers for the API request
headers = {"X-Emby-Token": api_key}

# Set the parameters for the API request to retrieve all media items
params = {
    "Recursive": "true",
    "IncludeItemTypes": "Movie,Episode",
    "SortBy": "SeriesName",
    "Fields": "Path",
}

# Make the API request and get the response
response = requests.get(f"{url}/Items", headers=headers, params=params)

json_response = response.json()

media_list = []
for item in json_response["Items"]:
    name = item["Name"]
    id = item["Id"]
    path = item["Path"]
    series = item.get("SeriesName", "")
    fileName = os.path.basename(path)
    index = re.search(r'S\d{2}E\d{2}', fileName).group(0) if re.search(r'S\d{2}E\d{2}', fileName) else None
    fName = f"{series}: {name} {index}"
    full_name = name if series == "" else fName
    download_url = f"{url}/Items/{id}/Download?api_key={api_key}"
    media_list.append({
        "Series": series,
        "Index": index,
        "Name": name,
        "File Name": fileName,
        "ID": id,
        "Path": path,
        "Full Name": full_name,
        "Download_URL": download_url
    })

# Sort the media list by Series, Name, and Index
media_list = sorted(media_list, key=lambda x: (x["Series"], x["Index"] if x["Index"] else x["Name"]))

# Create and open the output file in write mode
with open("portable_config\cache\jellyfin\jelly-indexer\indexed-jellyfin-libary.m3u", "w") as f:
    # Write the m3u header to the file
    f.write("#EXTM3U\n")
    # Write each media item to the file in m3u format
    for media in media_list:
        f.write(f"#EXTINF:-1,{media['Full Name']}\n{media['Download_URL']}\n")
