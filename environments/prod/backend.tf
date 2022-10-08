
terraform {
  backend "gcs" {
    bucket = "lzpeksprodbucket"
    prefix = "environments/prod"
  }
}

data "terraform_remote_state" "bootstrap" {
    backend = "gcs"
    config = {
      bucket = "lzpekscommonbckt"
      prefix = "environments/bootstrap"
    }  
}

data "terraform_remote_state" "common" {
    backend = "gcs"
    config = {
      bucket = "lzpekscommonbckt"
      prefix = "environments/common"
    }
}

