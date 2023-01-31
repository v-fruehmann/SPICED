import pandas as pd
import numpy as np
import pickle

#load cleaned dataframe 
df = pd.read_csv('/Users/Varvara/spiced_working_files/cleaned_df.csv', index_col=0)

#create R matrix
ratings =df.pivot_table(index='userId', columns='title', values='rating')
ratings.fillna(ratings.mean().mean(),inplace=True)
 
#create dictionaries
unique_movies = df['title'].unique()
movie_list = df['title'].tolist()
movies_dict = {unique_movies[i] : i for i in range(len(unique_movies))}

movie_title_dict={key:value for (value,key) in enumerate(movies_dict)}
movie_title_dict


def convert_query(query):
    # 1. candiate generation
    count = 0
    new_query = {}
    # construct a user vector
    for movie in ratings.columns:
        if movie not in query:

            new_query[movie] = np.nan
            # new_query.append(fuzzy[0])
        else:
            new_query[movie] = query[movie]

    new_query = pd.DataFrame(new_query, index=[0])
    new_query = np.array(new_query).reshape(1, -1)

    return new_query

query = {'Silence of the Lambs, The (1991)': 5, 'Fight Club (1999)': 5,
         'The Butterfly Effect (2004)': 4,
         '(500) Days of Summer (2009)': 5,
         "Schindler's List (1993)": 5,}
print(convert_query(query))


def get_movies_name(movieId):
    mov_df = pd.read_csv('/Users/Varvara/spiced_working_files/cleaned_df.csv', index_col=0)
    movie_name=mov_df[mov_df.index==int(movieId)]['title'].values[0]
    return movie_name


#create top 25 list movies based on the sum of ratings
ratings.loc['rating_sum'] = ratings.sum(axis=0)
top25=ratings.sort_values(by='rating_sum',axis=1, ascending=False).iloc[-1:, 0:25].columns.to_list()

# save dictionaries
dictionaries = [movies_dict, movie_title_dict, top25]

with open('/Users/Varvara/spiced_working_files/pickle_dictionaries.p', 'wb') as f1:
    pickle.dump(dictionaries, f1)

