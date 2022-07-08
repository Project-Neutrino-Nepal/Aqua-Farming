import os
import pickle

import numpy as np
import pandas as pd
from flask import Flask, jsonify, redirect, render_template, request, url_for
from flask_cors import CORS

app = Flask('Fish API')
CORS(app)
# enable debugging mode
app.config["DEBUG"] = True

# Upload folder
UPLOAD_FOLDER = 'static/files'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER


@app.route('/')
def index():
    # Set The upload HTML template '\templates\index.html'
    return render_template('uploader.html')


# Get the uploaded files
@app.route("/", methods=['POST'])
def uploadFiles():
    # get the uploaded file
    uploaded_file = request.files['file']
    if uploaded_file.filename != '':
        file_path = os.path.join(
            app.config['UPLOAD_FOLDER'], uploaded_file.filename)
        # set the file path
        uploaded_file.save(file_path)
        # save the file
    return redirect(url_for('recommend'))


@app.route('/recommend')
def recommend():
    csvData = pd.read_csv('./static/files/test_data.csv')

    model_pred = './static/files/model.pkl'

    x_test = np.asarray(csvData).astype(np.float32)

    cv = pickle.load(open(model_pred, "rb"))
    y_pred = cv.predict(x_test)
    predicted = np.argmax(y_pred, axis=1)
    
    return jsonify(f"Predicted: {predicted}")

    # return jsonify({'message': 'Hello, world!'})


if __name__ == '__main__':
    app.run(debug=True)
    app.run(host='0.0.0.0', port=8080)
