## Create an API key

1. First, you will set an environment variable with your PROJECT_ID which you will use throughout this lab:

```shell
export GOOGLE_CLOUD_PROJECT=$(gcloud config get-value core/project)
```

2. Next, create a new service account to access the API:

```shell
gcloud iam service-accounts create my-service \
  --display-name "my service account"
```

3. Then, create credentials to log in as your new service account. Create these credentials and save it as a JSON file "~/key.json" by using the following command:

```shell
gcloud iam service-accounts keys create ~/key.json \
  --iam-account my-service@${GOOGLE_CLOUD_PROJECT}.iam.gserviceaccount.com
```

4. Finally, set the GOOGLE_APPLICATION_CREDENTIALS environment variable. The environment variable should be set to the full path of the credentials JSON file you created, which you can see in the output from the previous command:

```shell
export GOOGLE_APPLICATION_CREDENTIALS=key.json
```

## Entity Analysis Request

1. SSH into a Compute Engine, run the following command for your content
```shell
gcloud ml language analyze-entities --content="your-content" > result.json
```
2. See the results
```shell
cat result.json
```