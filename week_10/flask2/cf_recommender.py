import pandas as pd
import numpy as np
import pickle
import random
from sklearn.decomposition import NMF
from movies_titles import ratings, convert_query, get_movies_name
from fuzzywuzzy import process
from scipy.spatial import distance


# load dictionaries 
with open('/Users/Varvara/spiced_working_files/pickle_dictionaries.p', "rb") as file1:
        dictionaries = pickle.load(file1)

movies_dict =dictionaries[0]
movie_title_dict = dictionaries[1]


def cf_model(df):
    """Collaborative Filtering Model"""
    df=df.T
    cf_array = distance.squareform(distance.pdist(df, metric='cosine'))
    cf_matrix = pd.DataFrame(cf_array) 
    return cf_matrix

cf_matrix = cf_model(ratings)


def cf_recommender(query):
    """Collaborative filtering recommender
    Parameter: user input - list of 3 movies"""
    for movie in query:              
        fuzzy = process.extractOne(movie, movies_dict.keys())              
        loc_similar = movie_title_dict[fuzzy[0]]
        neighbour_movies = cf_matrix.loc[loc_similar].sort_values(ascending=False)  
        top3 = neighbour_movies.sort_values(ascending=False)[:3]
        top3 = top3.to_frame()
        top3 = pd.DataFrame(top3)
        top3_list= list(top3.index)
    
    recommendations = []
    for m in top3_list:
        movie_title = get_movies_name(m)
        recommendations.append(movie_title)

    return recommendations

if __name__== '__main__':
    query = {'Silence of the Lambs, The (1991)': 5, 
         'Fight Club (1999)': 5,
         'The Butterfly Effect (2004)': 4,
         '(500) Days of Summer (2009)': 5,
         "Schindler's List (1993)": 5,}
    recommendations = cf_recommender(query = query)
    print(recommendations)
            
