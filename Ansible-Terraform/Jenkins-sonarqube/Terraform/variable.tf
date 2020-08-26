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
  default     = ""
}

variable "aws_ami" {
  description = "AWS ami ubuntu 18.04"
  type        = string
  default     = ""
}
variable "eksctl_vpc" {
  description = "eksctl vpc id"
  type        = string
  default     = "" 
}
variable "aws_instance_type" {
  description = "AWS machine size"
  type        = string
  default     = ""
}
variable "aws_key_name" {
  description = "AWS key name - Already created"
  type        = string
  default     = ""
}

variable "sg_eksctl" {
  description = "eksctl sg for node communication"
  type        = string
  default     = "sg-0f468123"
}

variable "sg_jumphost" {
  description = "sg assigned to jump host"
  type        = string
  default     = "sg-04f123"
}

variable "private_subnet_eksctl" {
  description = "subent id's of private subnet"
  type        = string
  default     = "subnet-07f1123" 
}

variable "public_subnets_eksctl" {
  description = "eksctl public subnets"
  type        = list(string)
  default     = ["subnet-01bee4c2123","subnet-0492934123","subnet-03591123" ]
}

variable "vpn_ip" {
  description = "VPN instance ip"
  type        = string
  default     = "1.2.3.4/32"
}
