#variable "DATABRICKS_ACCOUNT_USERNAME" {}
#variable "DATABRICKS_ACCOUNT_PASSWORD" {}
#a little confused as to why this is here considering that Oauth was an options, but Workspace level API calls apparently need a username and password? Why? exactly?
variable "DATABRICKS_ACCOUNT_ID" {
  description = "Databricks account ID"
  type        = string  
  
}

variable "tags" {
  default = {}
}

variable "cidr_block" {
  default = "10.4.0.0/16"
}

variable "region" {
  default = "us-east-2"
}

resource "random_string" "naming" {
  special = false
  upper   = false
  length  = 6
}

locals {
  prefix = "LabEnv-${random_string.naming.result}"
}