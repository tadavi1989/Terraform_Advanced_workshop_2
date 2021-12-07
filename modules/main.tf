terraform {
   backend "s3" {
    bucket = "workshop-tf-state"
    key = "workshop-production-env-state/terraform.tfstate"
    dynamodb_table = "tf-workshop-env-locks"
    region = us-east-1
  }
}

provider "aws" {
  region = us-east-1
}


module "workshop-app" {
  source = "../workshop-app"
}


module "workshop-app2" {
  source = "../workshop-app"
}

module "rds-global" {
  source = "../rds-global"
}

