variable "image" {
  default = "factoriotools/factorio:stable"
}

variable "desired_container_count" {
  default = 1
  type    = number
  validation {
    condition     = var.desired_container_count == 0 || var.desired_container_count == 1
    error_message = "Only values of 0 or 1 are supported"
  }
}

variable "domain" {
  default = "chriswallace.io"
}

variable "subdomain" {
  default = "factorio"
}

variable "aws_access_key_id" {
  type        = string
  description = "An AWS IAM access key ID which terraform will use to access AWS on your behalf to manage resources"
}

variable "aws_secret_key" {
  type        = string
  description = "The secret key of the IAM access keypair used in the previous variable"
  sensitive   = true
}
