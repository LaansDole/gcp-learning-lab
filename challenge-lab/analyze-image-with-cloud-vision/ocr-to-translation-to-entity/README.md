# ML APIs Combination
Vision API's OCR method extracted text from an image, then the Translation API translated that text to English and the Natural Language API to found entities in that text.
- ***Refer to my other README files for how Cloud Storage Bucket is created***

## 1. Create your Cloud Vision API request

In this task, you will create a JSON request file for the Cloud Vision API. This request will be used to perform optical character recognition (OCR) on an image stored in a Google Cloud Storage bucket.

### Steps

1. Open your Cloud Shell environment.

2. Create a new file named `ocr-request.json`. You can do this using one of your preferred command line editors (nano, vim, emacs), or you can use the built-in code editor in Cloud Shell.

3. Add the following JSON structure to your `ocr-request.json` file:

```json
{
  "requests": [
      {
        "image": {
          "source": {
              "gcsImageUri": "gs://my-bucket-name/sign.jpg"
          }
        },
        "features": [
          {
            "type": "TEXT_DETECTION",
            "maxResults": 10
          }
        ]
      }
  ]
}
```

Please replace `my-bucket-name` with the name of the bucket you created.

4. Save and close the file.

This JSON structure is a request for the Cloud Vision API. It specifies that you want to use the `TEXT_DETECTION` feature of the API, which will run OCR on the image to extract text. The `maxResults` parameter is set to 10, which means the API will return up to 10 text detection results.

- ***You have now created your Cloud Vision API request.***

Sure, here's a README file for the next steps:

## 2. Call the Cloud Vision API and Save the Response

In this task, you will call the Cloud Vision API using the `ocr-request.json` file you created in the previous task. You will then save the response to a file named `ocr-response.json`.

### Steps

1. In your Cloud Shell environment, run the following command:

```bash
curl -s -X POST -H "Content-Type: application/json" --data-binary @ocr-request.json  https://vision.googleapis.com/v1/images:annotate?key=${API_KEY}
```

This command sends a POST request to the Cloud Vision API. The `-s` option silences curl's progress output. The `-X POST` option specifies that this is a POST request. The `-H "Content-Type: application/json"` option sets the content type of the request to JSON. The `--data-binary @ocr-request.json` option includes the contents of the `ocr-request.json` file in the request body. The URL specifies the endpoint of the Cloud Vision API, and `${API_KEY}` should be replaced with your actual API key.

2. The first part of the response should look like the following:

```json
{
  "responses": [
    {
      "textAnnotations": [
        {
          "locale": "fr",
          "description": "LE BIEN PUBLIC\nles dépêches\nPour Obama,\nla moutarde\nest\nde Dijon\n",
          ...
        },
        ...
      ]
    }
  ]
}
```

This is the OCR result from the Cloud Vision API. It includes the detected text, the language of the text, and the bounding box coordinates for each piece of text.

3. To save the response for later use, run the following command:

```bash
curl -s -X POST -H "Content-Type: application/json" --data-binary @ocr-request.json  https://vision.googleapis.com/v1/images:annotate?key=${API_KEY} -o ocr-response.json
```

This command is similar to the previous one, but it includes the `-o ocr-response.json` option, which saves the response to a file named `ocr-response.json`.

- ***You have now called the Cloud Vision API and saved the response. The next step is to translate the detected text.***

## 3. Send Text from the Image to the Translation API

In this task, you will send the text extracted from the image to the Translation API. The Translation API can translate text into over 100 languages and can also detect the language of the input text.

### Steps

1. Create a `translation-request.json` file with the following content:

```json
{
  "q": "your_text_here",
  "target": "en"
}
```

In this JSON structure, `q` is where you'll pass the string to translate.

2. Save the file.

3. Run the following Bash command in Cloud Shell to extract the image text from the previous step and copy it into a new `translation-request.json` file (all in one command):

```bash
STR=$(jq .responses[0].textAnnotations[0].description ocr-response.json) && STR="${STR//\"}" && sed -i "s|your_text_here|$STR|g" translation-request.json
```

4. Now you're ready to call the Translation API. Run the following command to send a request to the Translation API and save the response into a `translation-response.json` file:

```bash
curl -s -X POST -H "Content-Type: application/json" --data-binary @translation-request.json https://translation.googleapis.com/language/translate/v2?key=${API_KEY} -o translation-response.json
```

5. Run the following command to inspect the file with the Translation API response:

```bash
cat translation-response.json
```
*Your `translation-response.json` should look like this:*
```json
{
  "data": {
    "translations": [
      {
        "translatedText": "THE PUBLIC GOOD dispatches For Obama, the mustard is from Dijon",
        "detectedSourceLanguage": "fr"
      }
    ]
  }
}
```
Now you can understand more of what the sign said! The `translatedText` field in the response contains the resulting translation, and the `detectedSourceLanguage` field indicates the detected source language (in this case, `fr` for French).

- ***In addition to translating the text from our image, you might want to do more analysis on it. That's where the Natural Language API comes in handy. Onward to the next step!***

## 4. Analyzing the Image's Text with the Natural Language API

In this task, you will analyze the text extracted from the image using the Natural Language API. The Natural Language API can help you understand text by extracting entities, analyzing sentiment and syntax, and classifying text into categories.

### Steps

1. Create a `nl-request.json` file with the following content:

```json
{
  "document":{
    "type":"PLAIN_TEXT",
    "content":"your_text_here"
  },
  "encodingType":"UTF8"
}
```

In this JSON structure, `type` is the type of the text (supported type values are `PLAIN_TEXT` or `HTML`), `content` is where you'll pass the text to send to the Natural Language API for analysis, and `encodingType` tells the API which type of text encoding to use when processing the text.

2. Save the file.

3. Run the following Bash command in Cloud Shell to copy the translated text into the content block of the Natural Language API request:

```bash
STR=$(jq .data.translations[0].translatedText  translation-response.json) && STR="${STR//\"}" && sed -i "s|your_text_here|$STR|g" nl-request.json
```

*Your `nl-request.json` should now contain the content*
```json
{
  "document":{
    "type":"PLAIN_TEXT",
    "content":"THE PUBLIC GOOD dispatches For Obama, the mustard is from Dijon"
  },
  "encodingType":"UTF8"
}
```

4. Now you're ready to call the Natural Language API. Run the following command to send a request to the Natural Language API:

```bash
curl "https://language.googleapis.com/v1/documents:analyzeEntities?key=${API_KEY}" \
  -s -X POST -H "Content-Type: application/json" --data-binary @nl-request.json
```

The response will contain the entities the Natural Language API found in the text. Each entity includes the name of the entity, the type of the entity, and the salience (a [0,1] range indicating how important the entity is to the text as a whole). For entities that have a Wikipedia page, the API provides metadata including the URL of that page along with the entity's mid (an ID that maps to this entity in Google's Knowledge Graph).