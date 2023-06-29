#Thisis apparently requried before hand, but I'm not sure why, but that is what hte docs say..
resource "aws_s3_bucket" "root_storage_bucket" {
  bucket_prefix = local.prefix
  force_destroy = true
  tags = merge(var.tags, {
    Name = local.prefix
  })
}

resource "aws_s3_bucket_acl" "root_storage_bucket" {
  bucket = aws_s3_bucket.root_storage_bucket.id
  acl = "private"
}

#resource "aws_s3_bucket_versioning" "root_storage_bucket" {
#  bucket = aws_s3_bucket.root_storage_bucket.id
#  enabled = false
#}

resource "aws_s3_bucket_public_access_block" "root_storage_bucket" {
  bucket             = aws_s3_bucket.root_storage_bucket.id
  ignore_public_acls = true
  depends_on         = [aws_s3_bucket.root_storage_bucket]
}

data "databricks_aws_bucket_policy" "this" {
  bucket = aws_s3_bucket.root_storage_bucket.bucket
}

resource "aws_s3_bucket_policy" "root_bucket_policy" {
  bucket = aws_s3_bucket.root_storage_bucket.id
  policy = data.databricks_aws_bucket_policy.this.json
}

resource "databricks_mws_storage_configurations" "this" {
  provider                   = databricks.mws
  account_id                 = var.DATABRICKS_ACCOUNT_ID
  bucket_name                = aws_s3_bucket.root_storage_bucket.bucket
  storage_configuration_name = local.prefix
}
