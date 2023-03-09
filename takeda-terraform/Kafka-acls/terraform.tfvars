// terraform.tfvars

# terraform service account API key with organisation Admin role to create ressources in ccloud
confluent_cloud_api_key    = "AAAAAAAAAAAA"
confluent_cloud_api_secret = "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
#kafka_rest_endpoint = "https://pkc-pgq85.us-west-2.aws.confluent.cloud:443"
kafka_api_key    = "AAAABBBBBBB"
kafka_api_secret = "CCCCCCCCCCCCCCCCCCCCCC"

env_takeda_id     = "env-7yyo1p"
cluster_takeda_id = "lkc-j37km2"



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
