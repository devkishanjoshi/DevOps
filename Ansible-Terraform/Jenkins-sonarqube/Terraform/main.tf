provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}


resource "aws_security_group" "jenkins-sonarqube" {
  name        = "jenkins-sonarqube"
  description = "Allow required inbound traffic"
  vpc_id      = var.eksctl_vpc

  ingress {
    description = "Jump host"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [var.sg_jumphost]
  }
  ingress {
    description = "Jenkins Inbound"
    from_port   = 8080
    to_port     = 8080
    protocol    = "TCP"
    security_groups = [aws_security_group.jenkins-sonarqube-lb.id]
  }
  ingress {
    description = "Sonar Inbound"
    from_port   = 9000
    to_port     = 9000
    protocol    = "TCP"
    security_groups = [aws_security_group.jenkins-sonarqube-lb.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jenkins-sonar" {
    ami              = var.aws_ami
    instance_type    = var.aws_instance_type 
    key_name         = var.aws_key_name     
    subnet_id        = var.private_subnet_eksctl
    security_groups  = [ aws_security_group.jenkins-sonarqube.id, var.sg_eksctl ]
    tags = {
        Name = "jenkins-sonar"
    }
    
  connection {
   user = "ubuntu"
   private_key= file("private_key_path")
   type="ssh"
   host = self.private_ip
}

provisioner "remote-exec" {
    inline = ["echo Hi"]
  }
  provisioner "local-exec" {
    command = "ansible-playbook  -i 'ubuntu@${self.private_ip},'   ../apply_aws.yml" 
  }
}

resource "aws_security_group" "jenkins-sonarqube-lb" {
  name        = "jenkins-sonarqube-lb"
  description = "jenkins-sonarqube-lb"
  vpc_id      = var.eksctl_vpc

   ingress {
    description = "VPN ip"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = [var.vpn_ip]
  }
  ingress {
    description = "gitlab ip"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["34.74.90.64/28"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# load Balancer
resource "aws_lb" "jenkins-sonarqube-lb" {
  name               = "jenkins-sonarqube-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.jenkins-sonarqube-lb.id]
  subnets            = var.public_subnets_eksctl 

  tags = {
    Name = "jenkins-sonarqube-lb"
  }
}

# Target groups
resource "aws_lb_target_group" "test-sonar" {
  name     = "test-sonar"
  port     = 9000
  protocol = "HTTP"
  vpc_id   = var.eksctl_vpc
  target_type = "instance"
}

resource "aws_lb_target_group" "test-jenkins" {
  name     = "test-jenkins"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.eksctl_vpc
  target_type = "instance"
  health_check {    
    healthy_threshold   = 3    
    unhealthy_threshold = 10    
    timeout             = 5    
    interval            = 10    
    path                = "/Jenkins/"    
    port                = "8080"  
  }
}


# Target group attachments

resource "aws_lb_target_group_attachment" "test-jenkins-tga" {
  target_group_arn  = aws_lb_target_group.test-jenkins.arn
  target_id         = aws_instance.jenkins-sonar.id
  port              = 8080
}

resource "aws_lb_target_group_attachment" "test-sonar-tga" {
  target_group_arn  =  aws_lb_target_group.test-sonar.arn
  target_id         =  aws_instance.jenkins-sonar.id
  port              =  9000
}

# listeners 
resource "aws_lb_listener" "jenkins-sonarqube-lb-listener" {
  load_balancer_arn = aws_lb.jenkins-sonarqube-lb.arn
  port              = "80"
  protocol          = "HTTP"
 
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test-sonar.arn
  }
}

# rule for jenkins
resource "aws_lb_listener_rule" "jenkins-rule" {
  listener_arn = aws_lb_listener.jenkins-sonarqube-lb-listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test-jenkins.arn
  }

  condition {
    path_pattern {
      values = ["/centralexJenkins*"]
    }
  }
}