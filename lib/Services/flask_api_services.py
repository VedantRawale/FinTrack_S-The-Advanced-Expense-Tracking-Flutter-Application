from flask import Flask, request, jsonify
import pickle

app = Flask(__name__)

category_dict = {0: "Food", 1: "Hygiene", 2: "Home", 3: "Stationery", 4: "Clothes", 5: "Others"}

# Assume these are your loaded model and vectorizer
classifier = None
tfidf = None

# Load the trained model and TF-IDF vectorizer
with open('lib\\ML\\MultinomialNB.pickle', 'rb') as f:
    classifier = pickle.load(f)

with open('lib\\ML\\tfidf.pickle', 'rb') as f:
    tfidf = pickle.load(f)

@app.route('/add_product', methods=['POST'])
def add_product():
    try:
        data = request.get_json(force=True)
        print(f'Received data: {data}')
        # Ensure 'product_name' is present and is a string
        if 'product_name' not in data or not isinstance(data['product_name'], str):
            raise ValueError("Input must contain a valid 'product_name'")

        # Transform user input using the trained TF-IDF vectorizer
        input_feature = tfidf.transform([data['product_name']]).toarray()
        # Predict the category for the input item
        prediction = classifier.predict(input_feature)
        # Map the predicted category to the corresponding label
        category = category_dict[prediction[0]]  # Use prediction[0] as it's a single prediction
        # Return the predicted category
        return jsonify({'category': category})
    except Exception as e:
        return jsonify({'error': str(e)})

if __name__ == '__main__':
   app.run(host='0.0.0.0', port=5000, debug=True)
