
terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.35.0"
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

data "confluent_service_account" "sa_name" {

  display_name = var.sa_name
}

resource "confluent_connector" "s3-sink" {
  environment {
    id = data.confluent_environment.env_takeda.id
  }
  kafka_cluster {
    id = data.confluent_kafka_cluster.cluster_takeda.id
  }

  // Block for custom *sensitive* configuration properties that are labelled with "Type: password" under "Configuration Properties" section in the docs:
  // https://docs.confluent.io/cloud/current/connectors/cc-s3-sink.html#configuration-properties
  config_sensitive = {
    "aws.access.key.id"     = "***REDACTED***"
    "aws.secret.access.key" = "***REDACTED***"
  }

  // Block for custom *nonsensitive* configuration properties that are *not* labelled with "Type: password" under "Configuration Properties" section in the docs:
  // https://docs.confluent.io/cloud/current/connectors/cc-s3-sink.html#configuration-properties
  config_nonsensitive = {
    "topics"                   = var.topic_name
    "input.data.format"        = "JSON"
    "connector.class"          = "S3_SINK"
    "name"                     = "S3_SINKConnector_0"
    "kafka.auth.mode"          = "SERVICE_ACCOUNT"
    "kafka.service.account.id" = "${data.confluent_service_account.sa_name.id}"
    "s3.bucket.name"           = var.bucket_name
    "output.data.format"       = "JSON"
    "time.interval"            = "DAILY"
    "flush.size"               = "1000"
    "tasks.max"                = "1"
  }
}
