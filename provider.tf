terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      #there is no version in the example yet it seems like it is using an older version of the AWS module?  Why? Oh god my eyes are bleeding.
    }
  }
}

provider "aws" {
  region = var.region
}

// initialize provider in "MWS" mode to provision new workspace
provider "databricks" {
  alias    = "mws"
  host     = "https://accounts.cloud.databricks.com"
  account_username = var.DATABRICKS_ACCOUNT_USERNAME
  account_password = var.DATABRICKS_ACCOUNT_PASSWORD
  account_id = var.DATABRICKS_ACCOUNT_ID
}