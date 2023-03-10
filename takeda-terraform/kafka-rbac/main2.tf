resource "confluent_role_binding" "sa1-developer-write-from-topic" {
  for_each = {
    for rd in var.service_accounts.sa1.role_definitions :
    "${var.service_accounts.sa1.display_name}_${rd.role_name}_${confluent_kafka_topic[rd.rbac_type].topic_name}" => rd
  }

  principal   = "User:${confluent_service_account.sa1.id}"
  role_name   = each.value.role_name

  crn_pattern = each.value.rbac_type == "topic" ?
                "${confluent_kafka_cluster.standard.rbac_crn}/kafka=${confluent_kafka_cluster.standard.id}/topic=${confluent_kafka_topic[each.value.rbac_type].topic_name}" :
                "${confluent_kafka_cluster.standard.rbac_crn}/kafka=${confluent_kafka_cluster.standard.id}/group=${confluent_kafka_group[each.value.rbac_type].group_name}"
}


service_accounts = {
  "sa1" = {
    display_name = "service-account-1"
    role_definitions = [
      {
        role_name   = "DeveloperWrite"
        crn_pattern = "${confluent_kafka_cluster.standard.rbac_crn}/kafka=${confluent_kafka_cluster.standard.id}/topic=${confluent_kafka_topic.orders.topic_name}"
        rbac_type   = "topic"
      },
      {
        role_name   = "DeveloperRead"
        crn_pattern = "${confluent_kafka_cluster.standard.rbac_crn}/kafka=${confluent_kafka_cluster.standard.id}/topic=${confluent_kafka_topic.shipments.topic_name}"
        rbac_type   = "topic"
      }
    ]
  },
  "sa2" = {
    display_name = "service-account-2"
    role_definitions = [
      {
        role_name   = "DeveloperWrite"
        crn_pattern = "${confluent_kafka_cluster.standard.rbac_crn}/kafka=${confluent_kafka_cluster.standard.id}/topic=${confluent_kafka_topic.customers.topic_name}"
        rbac_type   = "topic"
      }
    ]
  }
}


variable "service_accounts" {
  description = "Service accounts and their roles."
  type        = map(object({
    display_name    = string
    role_definitions = list(object({
      role_name   = string
      crn_pattern = string
      rbac_type   = string
    }))
  }))
}
