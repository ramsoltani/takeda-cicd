def lambda_handler(event, context):
    result_list = []
    for record in event:
        payload = json.loads(record["payload"]["value"])
        result_list.append(payload)
        # Get the access token from the OAuth endpoint
        access_token = get_access_token(client_id="xxxxxxxxxxxxxxx",
                                    client_secret="xxxxxxxxxxxxxxxx",
                                    account_id="111111111")
        if not access_token:
            print("Could not obtain access token")

        headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {access_token}"
        }
        print(headers)
    url = "https://xxxxxxxxxxxxxx.rest.marketingcloudapis.com/data/v1/async/dataextensions/key:xxxxxxxxxxxxxxxxxxxxx/rows"
    response = requests.put(url, headers=headers, data=json.dumps(payload))

    if response.status_code == 200 or response.status_code == 201:
        return {
        "statusCode": response.status_code,
        "body": json.dumps("Successful request")
        }
    else:
        return result_list
    #    "statusCode": response.status_code,

    #    "body": json.dumps("Request failed")
    #    "payload": payload,
    #    "record" : record
    #   }
