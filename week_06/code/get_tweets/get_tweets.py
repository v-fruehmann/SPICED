import tweepy
import credentials
import pymongo
from pymongo import MongoClient

# Create a connection to MongoDB
# host = name of mongodb container, port = port of container
client = pymongo.MongoClient(host="mongodb", port=27017)

# define db name
db = client.twitter

# define collection name
dbcoll = db.tweets

##################
# Authentication #
##################

BEARER_TOKEN = credentials.Bearer_Token

client = tweepy.Client(
    bearer_token=BEARER_TOKEN,
    wait_on_rate_limit=True,
)

########################
# Get User Information #
########################

# https://docs.tweepy.org/en/stable/client.html#tweepy.Client.get_user
# https://developer.twitter.com/en/docs/twitter-api/data-dictionary/object-model/user

response = client.get_user(
    username='elonmusk',
    user_fields=['created_at', 'description', 'location',
                 'public_metrics', 'profile_image_url']
)

user = response.data

print(dict(user))


#########################
# Get a user's timeline #
#########################

# https://docs.tweepy.org/en/stable/pagination.html#tweepy.Paginator
# https://docs.tweepy.org/en/stable/client.html#tweepy.Client.get_users_tweets
# https://developer.twitter.com/en/docs/twitter-api/data-dictionary/object-model/tweet

cursor = tweepy.Paginator(
    method=client.get_users_tweets,
    id=user.id,
    exclude=['replies', 'retweets'],
    tweet_fields=['author_id', 'created_at', 'public_metrics']
).flatten(limit=20)

for tweet in cursor:
    print(tweet.text)


#####################
# Search for Tweets #
#####################

# https://docs.tweepy.org/en/stable/client.html#tweepy.Client.search_recent_tweets
# https://developer.twitter.com/en/docs/twitter-api/tweets/search/integrate/build-a-query

# - means NOT
search_query = "elon musk -is:retweet -is:reply -is:quote lang:de -has:links"

cursor = tweepy.Paginator(
    method=client.search_recent_tweets,
    query=search_query,
    tweet_fields=['author_id', 'created_at', 'public_metrics'],
).flatten(limit=20)

for tweet in cursor:
    print(tweet.text+'\n')
    db.tweets.insert_one(dict(tweet))


#with open("output_tweets.txt", "w") as f:
    #f.write(tweet.text)
    #f.write(str(tweet.created_at))