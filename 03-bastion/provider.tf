terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
   backend "s3" {
    bucket = "dwas-78s-remote-state"
    key    = "expense-dev-bastion"
    region = "us-east-1"
    dynamodb_table = "dwas-78s-locking"
  }
}

#provid authentication here
provider "aws" {
  region = "us-east-1"
}

# terraform {
#   required_providers {
#     aws = {
#       source = "hashicorp/aws"
#       version = "~> 6.0"
#     }
#   }
#    backend "s3" {
#     bucket = "dwas-78s-remote-state"
#     key    = "expense-dev-bastion"
#     region = "us-east-1"
#     dynamodb_table = "dwas-78s-locking"
#   }
# }

# #provid authentication here
# provider "aws" {
#   region = "us-east-1"
# }