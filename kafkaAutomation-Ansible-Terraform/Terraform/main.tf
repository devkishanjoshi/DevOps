provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
resource "aws_security_group" "kafka-zookeeper" {
  name        = "kafka-zookeeper"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.eksctl_vpc

  ingress {
    description = "Internal Access"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = "true"
  }
  ingress {
    description = "Jump host"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [var.sg_jumphost]
  }
  ingress {
    description = "k8s access"
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    security_groups = [var.sg_eksctl]
  }
  ingress {
    description = "VPN ip"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpn_ip]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "kafka" {
    count = length(var.private_subnets_eksctl)
    ami              = var.aws_ami
    instance_type    = var.aws_instance_type
    key_name         = var.aws_key_name
    subnet_id        = var.private_subnets_eksctl[count.index]
    security_groups  = [ var.sg_eksctl, aws_security_group.kafka-zookeeper.id ]
    tags = {
        Name = "${format("kafka-%d", count.index + 1)}"
    }
}

resource "aws_instance" "zookeeper" {
    count = length(var.private_subnets_eksctl)
    ami              = var.aws_ami
    instance_type    = var.aws_instance_type
    key_name         = var.aws_key_name
    subnet_id        = var.private_subnets_eksctl[count.index]
    security_groups  = [ var.sg_eksctl, aws_security_group.kafka-zookeeper.id ]
    tags = {
        Name = "${format("zookeeper-%d", count.index + 1)}"
    }
}

resource "aws_instance" "zk-tools" {
    ami              = var.aws_ami
    instance_type    = var.aws_instance_type
    key_name         = var.aws_key_name
    subnet_id        = var.public_subnet_eksctl
    security_groups  = [ aws_security_group.kafka-zookeeper.id ]
    tags = {
        Name = "zk-tools"
    }
}