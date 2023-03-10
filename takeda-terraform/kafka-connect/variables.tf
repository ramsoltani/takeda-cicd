variable "confluent_cloud_api_key" {
  description = "Confluent Cloud API Key (also referred as Cloud API ID)"
  type        = string
}

variable "confluent_cloud_api_secret" {
  description = "Confluent Cloud API Secret"
  type        = string
  sensitive   = true
}

variable "kafka_api_key" {
  description = "Confluent Cluster API Key"
  type        = string
}

variable "kafka_api_secret" {
  description = "Confluent Cluster API secret"
  type        = string
}

variable "env_takeda_id" {
  type        = string
  description = "The ID of the Confluent environment to use."
}

variable "cluster_takeda_id" {
  type        = string
  description = "The ID of the Confluent Kafka cluster to use."
}

variable "sa_name" {
  type        = string
  description = "The name of the Confluent service account to use."
}

variable "topic_name" {
  type        = string
  description = "The name of the Kafka topic to use for the connector."
}

variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket to use for the connector."
}
