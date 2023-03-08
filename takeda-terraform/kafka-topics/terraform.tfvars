// terraform.tfvars

# terraform service account API key with organisation Admin role to create ressources in ccloud
confluent_cloud_api_key    = "XXXXXXXXXXX"
confluent_cloud_api_secret = "YYYYYYYYYYYYYYYYYYYYYYYYYYYY"
#kafka_rest_endpoint = "https://pkc-pgq85.us-west-2.aws.confluent.cloud:443"
kafka_api_key    = "AAAAAAAAAAAAAAA"
kafka_api_secret = "5BBBBBBBBBBBBBBBBBBBBBBBBBBBB"

env_takeda_id     = "env-7yyo1p"
cluster_takeda_id = "lkc-j37km2"




#data_test_topic = "takeda-test"
topics = {
  takeda-ods = {
    partitions_count = 6
    cleanup_policy   = "compact"
  }
  takeda-aws = {
    partitions_count = 6
    cleanup_policy   = "compact"
  }
}
