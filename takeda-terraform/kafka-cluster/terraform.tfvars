// terraform.tfvars
# terraform service account API key with organisation Admin role to create ressources in ccloud
confluent_cloud_api_key    = "AAAAAAAAAAAAAAAAA"
confluent_cloud_api_secret = "AAAAAAAAAAAAAAAAABBBBBBBBBBBB"


private_link_network = "id-network"
# The AWS account ID to enable for the Private Link Access.
# You can find your AWS account ID here (https://console.aws.amazon.com/billing/home?#/account) under My Account section of the AWS Management Console. Must be a 12 character string.
aws_account_id = "492737776546"

# The VPC ID that you want to connect to Confluent Cloud Cluster
# https://us-east-1.console.aws.amazon.com/vpc/home?region=us-east-1#vpcs:
# DNS hostnames and DNS resolution should be enabled:
# * Your VPC -> Actions -> Edit DNS hostnames
# * Your VPC -> Actions -> Edit DNS resolution
vpc_id = "vpc-047944e470c1d51db"

# The region of your VPC that you want to connect to Confluent Cloud Cluster
# Cross-region AWS PrivateLink connections are not supported yet.
region = "us-west-2"

# The map of Zone ID to Subnet ID. You can find subnets to private link mapping information by clicking at VPC -> Subnets from your AWS Management Console (https://console.aws.amazon.com/vpc/home)
# https://us-west-1.console.aws.amazon.com/vpc/home?region=us-east-1#subnets:search=vpc-abcdef0123456789a
# You must have subnets in your VPC for these zones so that IP addresses can be allocated from them.
subnets_to_privatelink = {
  "usw2-az1" = "subnet-0b7590362ae2e19da",
  "usw2-az2" = "subnet-064343a3fbf437eac",
  "usw2-az3" = "subnet-0327396ad03034a36",
}


env_takeda_id = "env-xxxxx"
