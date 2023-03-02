# Takeda-CICD

This repository contains the necessary files to provision a Confluent component connector with Ansible, and to generate a hosts file used by Ansible for the deployment.


# inventory.j2
> **inventory.j2** is an Ansible template file used for provisioning a Confluent component connector with Ansible. The file contains configurations for connection with Confluent Cloud Kafka broker and Confluent Cloud Schema Registry, and the plugins to add to the connector.

The following variables are defined in the file:

*ansible_connection*: The connection method for Ansible, set to SSH
*ansible_user*: The username to use for SSH connection, populated with the value of cluster_data.ssh_username
*ansible_become*: Whether to become a privileged user after connecting via SSH, set to true
*ansible_ssh_private_key_file*: The path to the SSH private key to use for authentication, populated with the value of cluster_data.ssh_key
*ccloud_kafka_enabled*: A flag to indicate whether to enable the use of Confluent Cloud Kafka broker
*ccloud_kafka_bootstrap_servers*: The bootstrap server for Confluent Cloud Kafka broker
*ccloud_kafka_key*: The API key for Confluent Cloud Kafka broker authentication
*ccloud_kafka_secret*: The API secret for Confluent Cloud Kafka broker authentication
*ccloud_schema_registry_enabled*: A flag to indicate whether to enable the use of Confluent Cloud Schema Registry
*ccloud_schema_registry_url*: The URL of Confluent Cloud Schema Registry
*ccloud_schema_registry_key*: The API key for Confluent Cloud Schema Registry authentication
ccloud_schema_registry_secret: The API secret for Confluent Cloud Schema Registry authentication
kafka_connect_cluster_name: The name of the Kafka Connect cluster to which the connector belongs
kafka_connect_custom_java_args: Custom Java arguments to pass to the Kafka Connect worker process, commented out by default
kafka_connect_confluent_hub_plugins: A list of Confluent Hub plugins to add to the Kafka Connect worker process

# hosts-dev.yml
> **hosts-dev.yml** is a YAML file that defines the list of hosts and their parameters to populate the Ansible hosts file.

The file contains the following variables:

cluster_data: A dictionary containing the SSH username and private key path for connecting to the hosts
ccloud_kafka_bootstrap_servers: The bootstrap server for Confluent Cloud Kafka broker
ccloud_kafka_key: The API key for Confluent Cloud Kafka broker authentication
ccloud_kafka_secret: The API secret for Confluent Cloud Kafka broker authentication
kafka_connect_cluster_name: The name of the Kafka Connect cluster to which the connector belongs
kafka_connect: A dictionary containing the IP addresses or hostnames of the Kafka Connect nodes and their corresponding public IP addresses
kafka_connect_confluent_hub_plugins: A list of Confluent Hub plugins to add to the Kafka Connect worker process

# generate_hosts.py
> **generate_hosts.py** is a Python script for generating the Ansible hosts file using the data from hosts-dev.yml and inventory.j2.

The script takes in three arguments:

-i/--inventory: The path to the hosts-dev.yml file


-t/--template: The path to the inventory.j2 template file


-o/--output: The path to the output Ansible hosts file


The script loads the data from hosts-dev.yml, loads the inventory.j2 template, renders the template

# Usage

To generate the hosts file, use the following command:

> python generate_hosts.py -i hosts-dev.yml -t inventory.j2 -o hosts.yml

To install a Confluent Connector with the generated hosts file, use this command:

> ansible-playbook -i hosts.yml confluent.platform.all --tags=kafka_connect


