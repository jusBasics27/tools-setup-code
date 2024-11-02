terraform {
  backend "s3" {
    bucket = "learnstatefilehassanwh"
    key    = "tools/terraform.tfstate"
    region = "us-east-1"
  }
}