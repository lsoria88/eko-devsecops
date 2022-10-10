terraform {
  backend "s3" {
    bucket         = "iac-tf-bucket-s3-ls88-v2"
    region         = "us-east-1"
    encrypt        = true
    key            = "lambdatf/deploy.tfstate"
    role_arn       = "arn:aws:iam::916514384804:role/Role_devsecops"
    #shared_credentials_file = "~/.aws/credentials"
  }
}