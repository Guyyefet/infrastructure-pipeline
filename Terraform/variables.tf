variable "region" {
  type = string
  default = "us-east-1"
  description = "aws region"
}

variable "vpc_cidr_block" {
  type = string
  description = "vpc_cidr_block"
}

variable "public_subnet" {
  type = string
  description = "the public subnet in the vpc"
}

variable "private_subnet" {
  type = string
  description = "the private subnet in the vpc"
}

variable "environment_name" {
  type = string
  description = "the environment name for this resource"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
  description = "instance type"
}

variable "local_storage" {
  type = string
  default = "excluded"
  description = "Indicate whether instance types with local storage volumes are included, excluded, or required."
}

variable "key_pair_name" {
  type = string
  description = "key pair name"
}

variable "min_size" {
  type = number
  description = "min size of instances in auto scale group"
}

variable "max_size" {
  type = number
  description = "max size of instances in auto scale group"
}

variable "CPUUtilization_target_value" {
  type = number
  description = "CPUUtilization target value"
}

# variable "instance_tags" {
#   type = object({
#     Name = string

#   })
# }



# variable "vpc_id" {
#   type = string
#   default = data.aws_vpc.dev-vpc.id
#   description = "vpc_id"
# }

# variable "regions" {
#   type = list(string)
#   description = "list of aws regions"
# }

# variable "availability_zones" {
#   type = list(string)
#   description = "availability zones"
# }

# variable "private_subnets" {
#   type = list(string)
#   description = "private subnets cidr blocks"
# }

# variable "public_subnets" {
#   type = list(string)
#   description = "public subnets cidr blocks"
# }

variable "ec2_traffic_port" {
   type = number
   default = 8080
}

variable "health_check_port" {
   type = number
   default = 8081
}

variable "ingress_alb_port" {
  type = number
  default = 80
}

variable "network_protocols" {
  type = list(string)
  default = []
}

variable "ingress" {
  type = string
  default = "ingress"
}

variable "egress" {
  type = string
  default = "egress"
}

