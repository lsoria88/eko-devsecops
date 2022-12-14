locals {
  function_name = "${var.app_id}-${var.app_env}"
  common_tags = {
    environment = var.app_env
    product_name = "${var.app_id}-${var.app_env}"
    deployment_type = "terraform"
    info_appid = "Demo"   
  }
}

variable "app_id" {
  description = "Nombre Lambda"
  type = string
  default = "http-crud-tutorial"
}

variable "app_env" {
  description = "Ambiente Despliegue"
  type = string
  default = "dev"
}

variable "aws_region" {
  description = "AWS region for all resources."
  type    = string
  default = "us-east-1"
}

variable "lambda_package" {
  description = "Path archivo ZIP a ser desplegado en AWS"
  type = string
  default = "lambda-tf-gitlab.zip"
}

variable "bucket"{
  description = "code bucket"
  type = string
  default = "iac-tf-bucket-s3-ls88-v3"
}
variable "repo_url" {
  description = "URL que usa el repositorio"
  type = string
  default = "https://gitlab.com/training-cloud/lambda-tf-gitlab.git"
}

variable "domain" {
  description = "dominio"
  type        = string
  default     = "api.autheracloud.com"
}
 
variable "read_capacity" {
    default = 10
}

variable "write_capacity" {
    default = 10
}

variable "aws_account_id" {
  description = "Cuentas Aws para desplegar"
  type        = string
  default = "677825415277"
}

variable "aws_role_name" {
  description = "El Rol AWS para que se despliegen las funciones."
  type        = string
}