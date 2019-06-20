variable "region" {
  type        = "string"
  default     = "eu-west-2"
  description = "The region in AWS"
}

variable "environment" {
  type        = "string"
  description = "The environment the application is deployed to"
}


variable "application_version" {
  type        = "string"
  description = "The version of the application"
}

