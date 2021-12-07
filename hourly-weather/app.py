# return current weather
from flask import Flask, jsonify, request
import requests
import os
import datetime

app = Flask(__name__)


@app.route('/')
def current_weather():
    return_response = {'hourly weather': [], 'location': {}}

    return_response['location']['latitude'] = '7.9272'
    return_response['location']['longitude'] = '80.8613'
    return_response['location']['name'] = "Kandy"

    start = datetime.datetime.now()
    end = datetime.datetime.now() + datetime.timedelta(hours=6)

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
        for i in range(1, 6):
            hourly_weather_object = {
                'time': datetime.datetime.strptime(response.json()['hours'][i]['time'][0:19], "%Y-%m-%dT%H:%M:%S").strftime("%Y-%m-%dT%H:%M SLTime"),
                'temperature': response.json()['hours'][i]['airTemperature']['sg'],
                'humidity': response.json()['hours'][i]['humidity']['sg'],
                'precipitation': response.json()['hours'][i]['precipitation']['sg'],
                'wind speed': response.json()['hours'][i]['windSpeed']['sg']
            }
            return_response['hourly weather'].append(hourly_weather_object)
    else:
        return_response['error'] = response.json()['errors']
    return jsonify(return_response)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
