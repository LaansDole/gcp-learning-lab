## Guide to upload a File to a Cloud Storage Bucket

This task involves sending an image to the Cloud Vision API for image detection. We will be using a Cloud Storage URL. The first step is to create a Cloud Storage bucket to store your images.

### Step 1: Create a Cloud Storage Bucket

1. From the Navigation menu, select `Cloud Storage > Buckets`.
2. Next to `Buckets`, click `Create`.
3. Give your bucket a unique name: `your-unique-bucket-name`.
4. After naming your bucket, click `Choose how to control access to objects`.
5. Uncheck `Enforce public access prevention on this bucket` and select the `Fine-grained` circle.
6. All other settings for your bucket can remain as the default setting.
7. Click `Create`.

### Step 2: Upload a File to Your Bucket

1. Go to the bucket you just created and click `UPLOAD FILES`, then select the file that you want to upload
2. You should see the file in your bucket.

### Step 3: Make the File Publicly Available

1. Click on the 3 dots for your uploaded file and select `Edit access`.
2. Click `Add entry` then enter the following:
   - Entity: `Public`
   - Name: `allUsers`
   - Access: `Reader`
3. Then click `Save`.

With the file in your bucket, you're ready to create a Cloud Vision API request, passing it the URL of this donuts picture.