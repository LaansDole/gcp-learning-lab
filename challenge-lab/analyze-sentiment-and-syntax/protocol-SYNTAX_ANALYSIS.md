## Create an API key

1. To create an API key, in the Cloud Console, select Navigation menu > APIs & Services > Credentials.

2. Click Create credentials and select API key.

3. Copy the generated API key and click Close.

## Create entity analysis requests
The first Natural Language API method you use is `analyzeEntities`. With this method, the API can extract entities (like people, places, and events) from text.
- *Create and modify [`syntax_request.json`](./syntax_request.json)*

The Natural Language API also supports sending files stored in Cloud Storage for text processing. If you wanted to send a file from Cloud Storage, you would replace `content` with `gcsContentUri` and give it a value of the text file's uri in Cloud Storage.

## Call the Natural Language API
Pass your request body, along with the API key environment variable, to the Natural Language API with the following `curl` command (all in one single command line):
```shell
curl "https://language.googleapis.com/v1/documents:analyzeSyntax?key=${API_KEY}" \
  -s -X POST -H "Content-Type: application/json" --data-binary @request.json > result.json
```
The Natural Language API can recognize the same entity mentioned in different ways.
