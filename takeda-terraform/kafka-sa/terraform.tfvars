// terraform.tfvars

# terraform service account API key with organisation Admin role to create ressources in ccloud
confluent_cloud_api_key    = "AAAAAAAAAAAAAAAAA"
confluent_cloud_api_secret = "AAAAAAAAAAAAAAAAABBBBBBBBBBBB"
#kafka_rest_endpoint = "https://pkc-pgq85.us-west-2.aws.confluent.cloud:443"
kafka_api_key    = "AAAAAAAAAAAAAAAAA"
kafka_api_secret = "AAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBB"

env_takeda_id     = "env-xxxxxx"
cluster_takeda_id = "lkc-xxxxx"

# Accounts list
accounts = {
  takeda-jdbc = {
    description = "Service account for jdbc source connector"
  }
  takeda-s3-sink = {
    description = "Service account for S3 sink connector"
  }
}
