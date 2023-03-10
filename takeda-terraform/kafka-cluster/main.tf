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

resource "confluent_network" "private-link" {
  display_name     = "Private Link Network"
  cloud            = "AWS"
  region           = var.region
  connection_types = ["PRIVATELINK"]
  zones            = keys(var.subnets_to_privatelink)
  environment {
    id = data.confluent_environment.env_takeda.id
  }
}

resource "confluent_private_link_access" "aws" {
  display_name = "AWS Private Link Access"
  aws {
    account = var.aws_account_id
  }
  environment {
    id = data.confluent_environment.env_takeda.id
  }
  network {
    id = confluent_network.private-link.id
  }
}

resource "confluent_kafka_cluster" "dedicated_inventory" {
  display_name = "inventory"
  availability = "MULTI_ZONE"
  cloud        = confluent_network.private-link.cloud
  region       = confluent_network.private-link.region
  dedicated {
    cku = 2
  }
  environment {
    id = data.confluent_environment.env_takeda.id
  }
  network {
    id = confluent_network.private-link.id
  }
}

resource "confluent_kafka_cluster" "dedicated_sales" {
  display_name = "sales"
  availability = "MULTI_ZONE"
  cloud        = confluent_network.private-link.cloud
  region       = confluent_network.private-link.region
  dedicated {
    cku = 4
  }
  environment {
    id = data.confluent_environment.env_takeda.id
  }
  network {
    id = confluent_network.private-link.id
  }
}
