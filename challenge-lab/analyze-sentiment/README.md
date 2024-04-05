## Guide to use App Script in Google Docs

1. On the Toolbar, choose **Extensions** -> **App Script**
2. In App Script, delete any existing functions and *paste* [nl-sentiment-analysis.js](./nl-sentiment-analysis.js) to the TextArea
***Note: You should look into the script and replace with your Natural Language API key***
3. Save the script
- There will be a new menu on the Document Toolbar
```javascript
function onOpen() {
  var ui = DocumentApp.getUi();
  ui.createMenu('Natural Language Tools')
    .addItem('Mark Sentiment', 'markSentiment')
    .addToUi();
}
```
4. Return to the Google Docs and choose any sections of the document that you wnat to mark sentiment

- You can use the following sentences to test
```text
This is a test that I am very frustrated with using the tool.

Although the tool is hard to use at first, I am starting to enjoy it!
```

5. Click on **Natural Language Tools** -> **Mark Sentiment** on the Toolbar

