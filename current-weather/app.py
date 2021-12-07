# return current weather
from flask import Flask, jsonify, request
import requests
import os
import datetime

app = Flask(__name__)


@app.route('/')
def current_weather():
    return_response = {'current weather': {}, 'location': {}}

    return_response['location']['latitude'] = request.args.get('lat')
    return_response['location']['longitude'] = request.args.get('lng')

    start = datetime.datetime.now()
    end = datetime.datetime.now() + datetime.timedelta(minutes=1)

    response = requests.get(
        'https://api.stormglass.io/v2/weather/point',
        params={
            'lat': float(request.args.get('lat')),
            'lng': float(request.args.get('lng')),
            'params': ','.join(['humidity', 'windSpeed', 'airTemperature', 'precipitation']),
            'source': 'sg',
            'start': start.strftime("%Y-%m-%dT%H:%M"),
            'end': end.strftime("%Y-%m-%dT%H:%M"),
        },
        headers={
            'Authorization': os.environ['stormglass_key']
        }
    )

    return_response['status'] = response.status_code
    return_response['time'] = datetime.datetime.now().strftime("%Y-%m-%dT%H:%M SLTime")
    if response.status_code == 200:
        return_response['current weather']['time'] = datetime.datetime.now().strftime("%Y-%m-%dT%H:%M SLTime")
        return_response['current weather']['temperature'] = response.json()['hours'][0]['airTemperature']['sg']
        return_response['current weather']['humidity'] = response.json()['hours'][0]['humidity']['sg']
        return_response['current weather']['precipitation'] = response.json()['hours'][0]['precipitation']['sg']
        return_response['current weather']['wind speed'] = response.json()['hours'][0]['windSpeed']['sg']
    else:
        return_response['error'] = response.json()['errors']
    return jsonify(return_response)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
