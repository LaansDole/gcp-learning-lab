## Create an API key

1. To create an API key, in the Cloud Console, select Navigation menu > APIs & Services > Credentials.

2. Click Create credentials and select API key.

3. Copy the generated API key and click Close.

## Create vision requests
The first Cloud Vision API method you use is `analyzeEntities`. With this method, the API can extract entities (like people, places, and events) from text.
- *Create and modify `request.json`*

The Cloud Vision API also supports sending files stored in Cloud Storage for text processing. If you wanted to send a file from Cloud Storage, you would replace `content` with `gcsContentUri` and give it a value of the text file's uri in Cloud Storage.

## Call the Cloud Vision API
Pass your request body, along with the API key environment variable, to the Cloud Vision API with the following `curl` command (all in one single command line):
```shell
curl https://vision.googleapis.com/v1/images:annotate?key=${API_KEY} \
  -s -X POST -H "Content-Type: application/json" --data-binary @request.json > result.json
```

