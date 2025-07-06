import requests, os

BASE_URL = os.getenv('SFC_BASE_URL')
API_KEY = os.getenv('SFC_API_KEY')

def delete_account_number(number):
    url = f"{BASE_URL}/v1/admin/accounts/{number}"
    headers = {"Authorization": f"Bearer {API_KEY}"}
    response = requests.delete(url, headers=headers)

    return response.json().get('success')