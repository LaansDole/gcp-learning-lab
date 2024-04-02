## Create an API key

1. To create an API key, click Navigation menu > APIs & services > Credentials.

2. Then click Create credentials.

3. In the drop down menu, select API key.

4. Copy the key you just generated and click Close.

## Create Speech-to-Text API requests
1. Create and modify `request.json`
```shell
nano request.json
```
2. Add the following to your `request.json` file, using the `uri` value of the sample raw audio file:
```json
{
  "config": {
      "encoding":"FLAC",
      "languageCode": "en-US"
  },
  "audio": {
      "uri":"gs://cloud-samples-tests/speech/brooklyn.flac"
  }
}
```
- In `config`, you tell he Speech-to-Text API how to process the request. 
- The `encoding` parameter tells the API which type of audio encoding you're using while the file is being sent to the API. 
- FLAC is the encoding type for .raw files.

## Call the Speech-to-Text API
Pass your request body, along with the API key environment variable, to the Speech-to-Text API with the following `curl` command (all in one single command line):
```shell
curl -s -X POST -H "Content-Type: application/json" --data-binary @request.json \
"https://speech.googleapis.com/v1/speech:recognize?key=${API_KEY}" > result.json
```