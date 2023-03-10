// terraform.tfvars

# terraform service account API key with organisation Admin role to create ressources in ccloud
<<<<<<< HEAD
confluent_cloud_api_key    = "AAAAAAAAAAAAAAAAA"
confluent_cloud_api_secret = "AAAAAAAAAAAAAAAAABBBBBBBBBBBB"
#kafka_rest_endpoint = "https://pkc-pgq85.us-west-2.aws.confluent.cloud:443"
kafka_api_key    = "AAAAAAAAAAAAAAAAA"
kafka_api_secret = "AAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBB"
=======
confluent_cloud_api_key    = "AAAAAAAAAAAA"
confluent_cloud_api_secret = "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
#kafka_rest_endpoint = "https://pkc-pgq85.us-west-2.aws.confluent.cloud:443"
kafka_api_key    = "AAAABBBBBBB"
kafka_api_secret = "CCCCCCCCCCCCCCCCCCCCCC"
>>>>>>> 2157e20f1d84e05be4f45ff2f1506eede79cc162

env_takeda_id     = "env-xxxxxx"
cluster_takeda_id = "lkc-xxxxx"



service_accounts = {
  "takeda-jdbc" = {
    acl_definitions = [
      {
        resource_type = "TOPIC"
        resource_name = "takeda-ods"
        pattern_type  = "LITERAL"
        host          = "*"
        operation     = "READ"
        permission    = "ALLOW"
      },
      {
        resource_type = "GROUP"
        resource_name = "group-1"
        pattern_type  = "LITERAL"
        host          = "*"
        operation     = "READ"
        permission    = "ALLOW"
      },
    ]
  },
  "takeda-s3-sink" = {
    acl_definitions = [
      {
        resource_type = "TOPIC"
        resource_name = "takeda-ods"
        pattern_type  = "LITERAL"
        host          = "*"
        operation     = "WRITE"
        permission    = "ALLOW"
      },
    ]
  },
}
