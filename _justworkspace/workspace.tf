terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
    }
  }
}

provider "databricks" {
  host  = "https://accounts.cloud.databricks.com"
  #this is problematic?  Where do I get a token for a workspace level function that doesn't exist yet?  Problem number 34!!
  token = var.DATABRICKS_TOKEN
}

variable "DATABRICKS_USERNAME" {
  description = "Databricks username"
  type        = string
}

variable "DATABRICKS_PASSWORD" {
  description = "Databricks password"
  type        = string
}

variable "DATABRICKS_ACCOUNT_ID" {
  description = "Databricks account ID"
  type        = string
}

resource "databricks_mws_workspaces" "this" {
  account_id    = var.DATABRICKS_ACCOUNT_ID
  #the workspace name needs to be randomized and unique for multiple students no?
  workspace_name = "my-workspace"
  deployment_name = "my-deployment"
  aws_region     = "us-west-2"
}