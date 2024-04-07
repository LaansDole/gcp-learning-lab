import requests
import base64
import json
import sys

# Function to get image bytes
def get_image_bytes(url):
    """
    This function takes an image URL as input, sends a GET request to that URL,
    and returns the base64 encoded content of the response.

    Args:
        url (str): The URL of the image.

    Returns:
        str: The base64 encoded content of the image.
    """
    response = requests.get(url)
    image_content = response.content
    return base64.b64encode(image_content).decode()

# Check command-line arguments
if len(sys.argv) != 2:
    print("Usage: python3 image_to_base64.py <image_url>")
    sys.exit(1)

# Get image URL from command-line argument
image_url = sys.argv[1]

# Get image bytes
image_bytes = get_image_bytes(image_url)

# Create JSON structure
data = {
  "instances": [{
    "content": image_bytes
  }],
  "parameters": {
    "confidenceThreshold": 0.5,
    "maxPredictions": 5
  }
}

# Convert Python dictionary to JSON
json_data = json.dumps(data)

# Save JSON to file
with open('predict_image.json', 'w') as json_file:
    """
    This block opens the file 'predict_image.json' in write mode,
    writes the JSON data to the file, and then automatically closes the file.
    """
    json_file.write(json_data)

print("JSON data has been written to predict_image.json")
