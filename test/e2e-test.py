# E2E testing

import sys
import requests
import random


class bcolors:
    OKGREEN = '\033[92m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'


stage_server_ip = sys.argv[1]
latitude = round(random.uniform(-90, 90), 6)
longitude = round(random.uniform(-180, 180), 6)

tests_cases = [
    {
        "name": "current weather",
        "url": f"http://{stage_server_ip}:5001?lat={latitude}&lng={longitude}",
        "success_status_codes": [200, 402]
    },
    {
        "name": "hourly weather",
        "url": f"http://{stage_server_ip}:5002?lat={latitude}&lng={longitude}",
        "success_status_codes": [200, 402]
    },
    {
        "name": "daily weather",
        "url": f"http://{stage_server_ip}:5003?lat={latitude}&lng={longitude}",
        "success_status_codes": [200, 402]
    }
]
results = []
for test_case in tests_cases:
    response = requests.get(test_case['url'])
    if response.json()['status'] in test_case['success_status_codes']:
        print(f"{test_case['name']} API test case is {bcolors.OKGREEN}!!! PASS !!!{bcolors.ENDC}")
        results.append("PASS")
    else:
        print(f"{test_case['name']} API test case is {bcolors.FAIL}!!! FAIL !!!{bcolors.ENDC}")
        results.append("FAIL")

if "FAIL" in results:
    sys.exit(1)
else:
    sys.exit(0)
