import pandas as pd
import numpy as np
import pickle
from sklearn.decomposition import NMF
from movies_titles import ratings, convert_query



# load dictionaries 
with open('/Users/Varvara/spiced_working_files/pickle_dictionaries.p', "rb") as file1:
        dictionaries = pickle.load(file1)

movies_dict =dictionaries[0]
movie_title_dict = dictionaries[1]




def recommend_nmf(query,ratings=ratings, model='nmf_model1.sav', k=10):
    """Filters and recommends the top k movies 
    for any given input query based 
    on a trained NMF model.

    Parameters
    ----------
    query : dict
        A dictionary of movies already seen. 
        Takes the form {"movie_A": 3, "movie_B": 3} etc
    nmf_model : pickle
        pickle nmf_model read from disk
    k : int, optional
        no. of top movies to recommend, by default 10
    """
    
    new_query = convert_query(query)
    user_dataframe = pd.DataFrame(new_query, index=[
                                  'Recommendation'], columns=ratings.columns).fillna(0)
    #print(user_dataframe)

    # 2. scoring
    #m = NMF(20)
    #m = m.fit(ratings)
    #Q = m.components_  
    #P = m.transform(ratings)
    #pickle.dump(m,open("nmf_model1.sav", "wb"))

    # calculate the score with the NMF nmf_model
    model = pickle.load(open("nmf_model1.sav", "rb"))
    
    # calculate the score with the NMF model
    user_P = model.transform(user_dataframe)
    Q = model.components_
    user_R = np.dot(user_P, Q)

    user_dataframe = pd.DataFrame(
        user_R, index=['Recommendation'], columns=ratings.columns)

    # 3. ranking

    # set zero score to movies already seen by the user
    unrated_boolean = np.isnan(new_query)[0]
    unrated_df = user_dataframe.iloc[:, unrated_boolean]
    sorted_new_user_df = unrated_df.T.sort_values(
        by='Recommendation', ascending=False).head(k)

    recommendations10= sorted_new_user_df.head(k)
    return list(recommendations10.index)
    
    
if __name__== '__main__':
    query = {'Silence of the Lambs, The (1991)': 5, 'Fight Club (1999)': 5,
         'The Butterfly Effect (2004)': 4,
         '(500) Days of Summer (2009)': 5,
         "Schindler's List (1993)": 5,}
    recommendations10 = recommend_nmf(query = query)
    print(recommendations10)
            

