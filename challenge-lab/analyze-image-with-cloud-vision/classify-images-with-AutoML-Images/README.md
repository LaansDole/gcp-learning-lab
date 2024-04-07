## 1. Set Up AutoML

This task involves setting up AutoML, which provides an interface for all the steps in training an image classification model and generating predictions on it. 

### Step 1: Enable the Cloud AutoML API

1. From the Navigation menu, select `APIs & Services > Library`.
2. In the search bar, type in "Cloud AutoML".
3. Observe that the Cloud AutoML API is in the `Enable` state.

### Step 2: Open the AutoML UI

Open the [Vertex AI Workbench](https://console.cloud.google.com/vertex-ai) in a new browser.

### Step 3: Create a Storage Bucket

Now, create a storage bucket by running the following command in `CloudShell`:

```bash
gsutil mb -p $GOOGLE_CLOUD_PROJECT \
    -c standard    \
    -l us \
    gs://$GOOGLE_CLOUD_PROJECT-vcm/
```

### Step 4: Verify the Storage Bucket

- In the Google Cloud console, open the Navigation menu and click on `Cloud Storage` to see it.

***With these steps, you have successfully set up AutoML for your project. You're now ready to proceed with training an image classification model and generating predictions on it.***

## 2. Upload Training Images to Cloud Storage

In order to train a model to classify images of clouds, you need to provide labelled training data. In this example, your model will learn to classify three different types of clouds: cirrus, cumulus, and cumulonimbus. To use AutoML, you need to put your training images in Cloud Storage.

### Step 1: Create an Environment Variable

Before adding the cloud images, create an environment variable with the name of your bucket. Run the following command in `Cloud Shell`:

```bash
export BUCKET=$GOOGLE_CLOUD_PROJECT-vcm
```

### Step 2: Copy Training Images to Your Bucket

The training images are publicly available in a Cloud Storage bucket. Use the `gsutil` command-line utility for Cloud Storage to copy the training images into your bucket:

```bash
gsutil -m cp -r gs://spls/gsp223/images/*** gs://${BUCKET}
```

### Step 3: Verify the Upload

- When the images finish copying, click the `Refresh` button at the top of the Storage browser, then click on your bucket name. You should see 3 folders of photos for each of the 3 different cloud types to be classified. If you click on the individual image files in each folder, you can see the photos you'll be using to train your model for each type of cloud.

***With these steps, you have successfully uploaded the training images to your Cloud Storage bucket. You're now ready to proceed with training your model.***

## 3. Create a Dataset

Now that your training data is in Cloud Storage, you need a way for AutoML to access it. You'll create a CSV file where each row contains a URL to a training image and the associated label for that image. 

### Step 1: Copy the CSV File to Your Cloud Shell Instance

Run the following command to copy the file to your Cloud Shell instance:

```bash
gsutil cp gs://spls/gsp223/data.csv .
```

### Step 2: Update the CSV with the Files in Your Project

Then update the CSV with the files in your project:

```bash
sed -i -e "s/placeholder/${BUCKET}/g" ./data.csv
```

### Step 3: Upload the CSV File to Your Cloud Storage Bucket

Now upload this file to your Cloud Storage bucket:

```bash
gsutil cp ./data.csv gs://${BUCKET}
```

Once that command completes, click the `Refresh` button at the top of the Storage browser. Confirm that you see the `data.csv` file in your bucket.

### Step 4: Create a Dataset in Vertex AI

1. Open the Vertex AI Dataset tab.
2. At the top of the console, click `+ Create`.
3. Type "clouds" for the Dataset name.
4. Select `Image classification (Single-label)`. Note: In your own projects, you may want to use multi-class classification.
5. Click `Create`.

### Step 5: Import Files from Cloud Storage

1. Choose `Select import files from Cloud Storage` and add the file name to the URL for the file you just uploaded - `your-bucket-name/data.csv`.
2. An easy way to get this link is to go back to the Cloud Console, click on the `data.csv` file and then go to the URI field.
3. Click `Continue`.

- It will take 5 - 15 minutes for your images to import. Once the import has completed, you'll be brought to a page with all the images in your dataset.

***With these steps, you have successfully created a dataset and are ready to proceed with training your model.***

## 4. Generate predictions
1. Return to `Cloud Shell` terminal
2. Create and modify [`image_to_base64_json.py`](./image_to_base64_json.py)
3. On your terminal, run the command below to create predict image JSON file:
```shell
python3 image_to_base64_json.py <your_image_url>
```
- You should see the line `JSON data has been written to predict_image.json`.
***You can also use the exising `Google Cloud Storage` and upload your image file. Remember to give public access to the uploaded image file.***
4. View the JSON file:
```cat
cat predict_image.json
```
5. Copy the Endpoint value to an environment variable:
```shell
ENDPOINT=$(gcloud run services describe automl-service --platform managed --region REGION --format 'value(status.url)')
```
5. Copy the JSON file to `INPUT_DATA_FILE` environment variable:
```shell
INPUT_DATA_FILE=predict_image.json
```
6. Run the following protocol:
```shell
curl -X POST -H "Content-Type: application/json" $ENDPOINT/v1 -d "@${INPUT_DATA_FILE}" | jq
```
7. If everything was done successfully, you should see the response like [this](./endpoint_response.txt)


