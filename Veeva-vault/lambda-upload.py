import os
import json
import requests

# Constants
VAULT_URL = 'https://developer.veevavault.com'
VAULT_USERNAME = 'vault_username'
VAULT_PASSWORD = 'vault_password'
VAULT_API_VERSION = 'v21.2'
EXPORT_FLAG_FIELD_NAME = 'c_export_flag__c'
PDF_FILE_FORMAT = 'PDF'
NONCLINICAL_DOCUMENT_TYPE = 'Nonclinical'
STUDY_REPORT_SUBTYPE = 'Study Reports'
STUDY_TYPE_LIST = ['Toxicology', 'Pharmacology', 'Pharmacokinetics']
APPROVED_DOCUMENT_STATUS = 'Approved'
PADOC_REPORT_FLAG = 'Yes'

# Initialize clients
session = requests.Session()
session.headers.update({'Content-Type': 'application/json'})

def get_session_id(username, password):
    data = {'username': username, 'password': password}
    response = session.post(f'{VAULT_URL}/api/{VAULT_API_VERSION}/auth', data=data)
    if response.status_code != 200:
        raise Exception(f"Error authenticating with Vault. Status code: {response.status_code}, message: {response.text}")
    return response.json()['sessionId']

def lambda_handler(event, context):
    # Authenticate with Vault
    session_id = get_session_id(VAULT_USERNAME, VAULT_PASSWORD)
    session.headers.update({'Authorization': session_id})

    # Fetch documents matching the criteria
    vql_query = f"SELECT id, name__v, version__v, type__v, subtype__v, format__v, padoc_report__c, owner__v.username__v, lifecycle__v, status__v FROM documents WHERE type__v='{NONCLINICAL_DOCUMENT_TYPE}' AND subtype__v='{STUDY_REPORT_SUBTYPE}' AND study__v.study_type__v IN {STUDY_TYPE_LIST} AND status__v='{APPROVED_DOCUMENT_STATUS}' AND format__v='{PDF_FILE_FORMAT}' AND padoc_report__c='{PADOC_REPORT_FLAG}' AND c_export_flag__c=false"
    response = session.get(f"{VAULT_URL}/api/{VAULT_API_VERSION}/query?q={vql_query}")
    if response.status_code != 200:
        raise Exception(f"Error fetching documents from Vault. Status code: {response.status_code}, message: {response.text}")
    documents = response.json()['data']

    # Download and export documents
    for document in documents:
        object_id = document['id']
        object_name = document['name__v']
        object_version = document['version__v']
        object_owner = document['owner__v.username__v']
        object_lifecycle = document['lifecycle__v']

        # Check if document has been migrated or already exported
        if object_lifecycle != 'active' or document['c_export_flag__c']:
            continue

        # Download document
        response = session.get(f"{VAULT_URL}/api/{VAULT_API_VERSION}/vobjects/{object_id}/file")
        if response.status_code != 200:
            raise Exception(f"Error downloading document {object_name}. Status code: {response.status_code}, message: {response.text}")

        # Export document to Vault staging server
        file_name = f"{object_id}_{object_name}_{object_version}.pdf"
        url = f"{VAULT_URL}/api/{VAULT_API_VERSION}/objects/documents/{object_id}/versions/{object_version}/export?document_id={object_id}"
        response = session.post(url, files={'file': response.content})
        if response.status_code != 200:
            raise Exception(f"Error exporting document {object_name}. Status code: {response.status_code}, message: {response.text}")


        # Update export flag on document
        export_flag_field = f"{EXPORT_FLAG_FIELD_NAME}"
        export_flag_data = {f"{export_flag_field}": True}
        url = f"{VAULT_URL}/api/{VAULT_API_VERSION}/objects/documents/{object_id}/versions/{object_version}"
        response = session.put(url, data=json.dumps(export_flag_data))
        if response.status_code != 204:
            raise Exception(f"Error updating export flag on document {object_name}. Status code: {response.status_code}, message: {response.text}")

        return {
            'statusCode': 200,
            'body': json.dumps('Documents exported successfully.')
        }
