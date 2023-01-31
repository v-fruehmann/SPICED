\c amazon

DROP TABLE IF EXISTS amazon_items;
CREATE TABLE amazon_items (
    name VARCHAR(500),
    asin VARCHAR(255) UNIQUE NOT NULL PRIMARY KEY,
    price NUMERIC,
    reviews_num NUMERIC,
    reviews NUMERIC,
    age NUMERIC,
    description TEXT,
    link VARCHAR(255),
    category VARCHAR(255),
    brand VARCHAR(255),
    price_range VARCHAR(255),
    age_range VARCHAR(255),
    good_reviews TEXT,
    bad_reviews TEXT
);

COPY amazon_items (
    name,
    asin,
    price,
    reviews_num,
    reviews,
    age,
    description,
    link,
    category,
    brand,
    price_range,
    age_range,
    good_reviews,
    bad_reviews)
FROM '/Users/Varvara/spiced_working_files/final_project/database/amazon_toys.csv' DELIMITER ',' CSV HEADER;

DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews (
    asin VARCHAR(255) UNIQUE NOT NULL PRIMARY KEY, 
    review_text TEXT, 
    title TEXT, 
    location_and_date VARCHAR(255), 
    rating VARCHAR(50),
    positive or negative VARCHAR(100)
    );
COPY reviews (
    review_text, 
    title, 
    location_and_date, 
    rating) 
FROM '/Users/Varvara/spiced_working_files/final_project/data/reviews.csv' DELIMITER ',' CSV HEADER;

