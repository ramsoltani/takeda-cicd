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

data "confluent_network" "private-link" {
  id = var.private_link_network
  environment {
    id = data.confluent_environment.env_takeda.id
  }
}

resource "confluent_kafka_cluster" "dedicated_inventory" {
  display_name = "inventory"
  availability = "MULTI_ZONE"
  cloud        = data.confluent_network.private-link.cloud
  region       = data.confluent_network.private-link.region
  dedicated {
    cku = 2
  }
  environment {
    id = data.confluent_environment.env_takeda.id
  }
  network {
    id = data.confluent_network.private-link.id
  }
}
