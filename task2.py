from os import environ
import requests
import time


region_env_name =environ.get('AWS_REGION')
print(region_env_name)
if (region_env_name):
    API_BASE = 'https://pricing.' + region_env_name + '.amazonaws.com'
    API_1 = API_BASE + '/offers/v1.0/aws/AmazonRDS/current/region_index.json'
    response = requests.get(API_1).json()
    # print(response.text)
    current_version_url = response['regions'][region_env_name]['currentVersionUrl']
    url = API_BASE + current_version_url
    url_response = requests.get(url.replace('json', 'csv'))
    filename = time.strftime("%Y%m%d-%H%M%S")+'.csv'
    f = open(filename,'w+')
    f.write(url_response.text)
    f.close


else:
    print ("missing param")