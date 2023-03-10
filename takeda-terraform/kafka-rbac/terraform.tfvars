// terraform.tfvars

# terraform service account API key with organisation Admin role to create ressources in ccloud
confluent_cloud_api_key    = "VQTTAWLCRNKTK2Q3"
confluent_cloud_api_secret = "/YKi14x9zlaJqmGPGWKOftCiM6FrCm/+9F/6QDmGhvpd5TVIMu8osLWEKJALVWzz"
#kafka_rest_endpoint = "https://pkc-pgq85.us-west-2.aws.confluent.cloud:443"
kafka_api_key    = "B7ANS2VSW6LMCDRP"
kafka_api_secret = "50H9pFWLTG7PPJUPld7nutfPnxvq3PWqoz3jsYCUvoeuvosT65uuiFtxqCezIxa7"

env_takeda_id     = "env-7yyo1p"
cluster_takeda_id = "lkc-j37km2"

service_accounts = {
  "sa1" = {
    display_name = "service-account-1"
    role_definitions = [
      {
        role_name   = "DeveloperWrite"
        crn_pattern = "${confluent_kafka_cluster.standard.rbac_crn}/kafka=${confluent_kafka_cluster.standard.id}/topic=${confluent_kafka_topic.orders.topic_name}"
      },
      {
        role_name   = "DeveloperRead"
        crn_pattern = "${confluent_kafka_cluster.standard.rbac_crn}/kafka=${confluent_kafka_cluster.standard.id}/topic=${confluent_kafka_topic.shipments.topic_name}"
      }
    ]
  },
  "sa2" = {
    display_name = "service-account-2"
    role_definitions = [
      {
        role_name   = "DeveloperWrite"
        crn_pattern = "${confluent_kafka_cluster.standard.rbac_crn}/kafka=${confluent_kafka_cluster.standard.id}/topic=${confluent_kafka_topic.customers.topic_name}"
      }
    ]
  }
}
