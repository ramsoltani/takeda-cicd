terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.34.0"
    }
  }
}

provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key
  cloud_api_secret = var.confluent_cloud_api_secret
}

data "confluent_environment" "env_takeda" {
  id = var.env_takeda_id
}

data "confluent_kafka_cluster" "cluster_takeda" {
  id = var.cluster_takeda_id
  environment {
    id = var.env_takeda_id
  }
}


// Provisioning Kafka Topics requires access to the REST endpoint on the Kafka cluster
// If Terraform is not run from within the private network, this will not work

resource "confluent_kafka_topic" "takeda_test" {
  kafka_cluster {
    id = data.confluent_kafka_cluster.cluster_takeda.id
  }
  for_each = var.topics

  topic_name       = each.key
  partitions_count = each.value.partitions_count
  # Additional configuration options

  rest_endpoint = data.confluent_kafka_cluster.cluster_takeda.rest_endpoint
  config = {
    "cleanup.policy" = each.value.cleanup_policy
  }

  credentials {
    key    = var.kafka_api_key
    secret = var.kafka_api_secret
  }
}
