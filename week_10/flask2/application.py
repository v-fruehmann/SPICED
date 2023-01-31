from flask import Flask, render_template, request
from cf_recommender import cf_recommender
from nmf_recommender import recommend_nmf

app = Flask(__name__)

@app.route('/')
@app.route('/main')  
def hello():
    return render_template('main.html', title1="MOVIE RECOMMENDER")


@app.route('/recommendations')
def recommender():
    user_input=request.args
    #print(request.args)
    #title = request.args.getlist('title')     
    #ratings = request.args.getlist('ratings')

    #print(user_input)  
         
    recommendations = recommend_nmf(user_input)
    similar_movies = cf_recommender(user_input)
    return render_template("recommender.html", recommendations = recommendations, similar_movies= similar_movies)


if __name__ == '__main__':
    app.run(debug=True, port=5000)


