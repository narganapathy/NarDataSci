import sys
import json

def hw():
    print 'Hello, world!'

def lines(fp):
    print str(len(fp.readlines()))

def getscores(scores, sent_file):
        sent_file.seek(0,0);
        for line in sent_file:
                term,score = line.split("\t"); # get the two values that are tab limited
                scores[term] = int(score);
        #print scores.items();

def compute_sentimentscore(tweet_text, scores, tweet_sentiments):
        sentiment_score = 0
        words = tweet_text.split();
        for word in words:
                asciiword = word.encode('utf-8')
                for term,score in scores.items():
                        if (asciiword.find(term) != -1):
                                sentiment_score += score
        tweet_sentiments[tweet_text] = sentiment_score

def gettweets(tweet_file, scores):
        tweet_file.seek(0,0);
        #print words
        #print scores.items();
        #print tweet.items();
        tweet_sentiments = {} # tracks sentiment score per tweet
        numlines = 0
        for line in tweet_file:
                tweet = json.loads(line); # get the tweet
                if ('text' in tweet):
                        #print (tweet["text"])
                        compute_sentimentscore(tweet["text"], scores, tweet_sentiments)
                numlines += 1
                if (numlines > 100) :
                        break

        for tweet,sent_score in tweet_sentiments.items():
                print(tweet, sent_score)



def main():
    sent_file = open(sys.argv[1])
    tweet_file = open(sys.argv[2])
    scores = {} #empty dictionary
    hw()
    lines(sent_file)
    lines(tweet_file)
    getscores(scores, sent_file);
    gettweets(tweet_file, scores)

if __name__ == '__main__':
    main()
