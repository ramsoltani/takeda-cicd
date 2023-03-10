// terraform.tfvars

# terraform service account API key with organisation Admin role to create ressources in ccloud
confluent_cloud_api_key    = "AAAAAAAAAAAA"
confluent_cloud_api_secret = "BBBBBBBBBBBBBBB"
#kafka_rest_endpoint = "https://pkc-pgq85.us-west-2.aws.confluent.cloud:443"
kafka_api_key    = "AAAAAAAAAAAA"
kafka_api_secret = "BBBBBBBBBBBBBBS"

env_takeda_id     = "env-7yxxx"
cluster_takeda_id = "lkc-xxxxx"

# Accounts list
accounts = {
  takeda-jdbc-heroku = {
    description = "Service account for jdbc source connector"
  }
  takeda-s3-sink = {
    description = "Service account for S3 sink connector"
  }
  takeda-lambda-sink = {
    description = "Service account for S3 sink connector"
  }
}
