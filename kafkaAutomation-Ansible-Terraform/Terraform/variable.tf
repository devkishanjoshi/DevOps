variable "aws_access_key" {
  description = "aws access key "
  type        = string
  default     = ""
}

variable "aws_secret_key" {
  description = "aws secret key"
  type        = string
  default     = ""
}
variable "aws_region" {
  description = "aws region"
  type        = string
  default     = "ap-east-1"
}
variable "aws_ami" {
  description = "Ubuntu Instance AMI"
  type        = string
  default     = "ami-107d3e61"    
}
variable "eksctl_vpc" {
  description = "eksctl vpc id"
  type        = string
  default     = "vpc-07d0bbd9" 
}
variable "aws_instance_type" {
  description = "Instance Type"
  type        = string
  default     = "t3.micro"      # preferred 
}
variable "aws_key_name" {
  description = "Key which must be created before"
  type        = string
  default     = "kafka"
}

variable "sg_eksctl" {
  description = "eksctl vpc"
  type        = string
  default     = "sg-0f46886ff13a78dc3"
}

variable "sg_jumphost" {
  description = "Jump Host security Group"
  type        = string
  default     = "sg-04fc09a1"
}

variable "private_subnets_eksctl" {
  description = "subent id's of private subnets"
  type        = list(string)
  default     = [ "subnet-07f1fc7ef0", "subnet-0694fbe2157", "subnet-006c4f0e9" ]
}

variable "public_subnet_eksctl" {
  description = "eksctl public vpc"
  type        = string
  default     = "subnet-01bee4c22d"
}

variable "vpn_ip" {
  description = "VPN instance ip"
  type        = string
  default     = "18.162.103.25/32"
}