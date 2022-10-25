variable "image" {
  default = "factoriotools/factorio:stable"
}

variable "domain" {
  default = "chriswallace.io"
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
