import argparse
import os

from google.cloud import language_v1
from google.cloud.language_v1 import types

def print_result(annotations):
    score = annotations.document_sentiment.score
    magnitude = annotations.document_sentiment.magnitude

    for index, sentence in enumerate(annotations.sentences):
        sentence_sentiment = sentence.sentiment.score
        print(
            "Sentence {} has a sentiment score of {}".format(index, sentence_sentiment)
        )

    print(
        "Overall Sentiment: score of {} with magnitude of {}".format(score, magnitude)
    )
    return 0

def analyze(movie_review_filename):
    """Run a sentiment analysis request on text within a passed filename."""
    # Instantiate a LanguageServiceClient instance
    client = language_v1.LanguageServiceClient()

    # Read the file contents
    with open(movie_review_filename, 'r') as review_file:
        content = review_file.read()

    # Instantiate a Document object with the contents of the file
    document = types.Document(
        content=content,
        type_=language_v1.Document.Type.PLAIN_TEXT
    )

    # Call the client's analyze_sentiment method
    annotations = client.analyze_sentiment(document=document)

    # Print the results
    print_result(annotations)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter
    )
    parser.add_argument(
        "movie_review_filename",
        help="The filename of the movie review you'd like to analyze.",
    )
    args = parser.parse_args()

    analyze(args.movie_review_filename)


# To run the python script
# python3 sentiment_analysis.py .txt file
