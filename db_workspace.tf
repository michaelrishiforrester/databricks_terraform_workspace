resource "databricks_mws_workspaces" "this" {
  provider        = databricks.mws
  account_id      = var.DATABRICKS_ACCOUNT_ID
  aws_region      = var.region
  workspace_name  = local.prefix
  deployment_name = local.prefix

  credentials_id           = databricks_mws_credentials.this.credentials_id
  storage_configuration_id = databricks_mws_storage_configurations.this.storage_configuration_id
  network_id               = databricks_mws_networks.this.network_id
}

// export host to be used by other modules
output "databricks_host" {
  value = databricks_mws_workspaces.this.workspace_url
}

// initialize provider in normal mode
provider "databricks" {
  // in normal scenario you won't have to give providers aliases
  alias = "created_workspace"
  host = databricks_mws_workspaces.this.workspace_url
}

// create PAT token to provision entities within workspace
resource "databricks_token" "pat" {
  provider = databricks.created_workspace
  comment  = "Terraform Provisioning"
  lifetime_seconds = 86400
}

// export token for integration tests to run on
output "databricks_token" {
  value     = databricks_token.pat.token_value
  sensitive = true
}