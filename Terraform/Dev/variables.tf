variable "region" {
  type = string
  default = "us-east-1"
  description = "aws region"
}

variable "environment_name" {
  type = string
  description = "the environment name for this resource"
}

variable "vpc_cidr_block" {
  type = string
  description = "vpc_cidr_block"
}

variable "availability_zones" {
  type = list(string)
  description = "value"
}

variable "public_subnets" {
  type = list(string)
  description = "the public subnet in the vpc"
}

variable "private_subnets" {
  type = list(string)
  description = "the private subnet in the vpc"
}

# variable "instance_type" {
#   type = string
#   default = "t2.micro"
#   description = "instance type"
# }

# variable "local_storage" {
#   type = string
#   default = "excluded"
#   description = "Indicate whether instance types with local storage volumes are included, excluded, or required."
# }

# variable "key_pair_name" {
#   type = string
#   description = "key pair name"
# }







