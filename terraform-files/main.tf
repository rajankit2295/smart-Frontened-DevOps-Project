terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.8.0"
    }
  }
}

provider "aws" {
  region = var.region
}


resource "aws_security_group" "main_sg" {
  name        = "main-sg"
  description = "Allow SSH, HTTP, Jenkins, Kubernetes"
  vpc_id      = "vpc-0f8ebd95d5f9dc930" # Update with your VPC ID

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Kubernetes API"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jenkins_master" {
  ami                    = var.ami
  instance_type          = var.jenkins_master
  key_name               = "raj-ankit"
  vpc_security_group_ids = [aws_security_group.main_sg.id]
  tags = {
    Name = "jenkins-master"
  }
}

resource "aws_instance" "jenkins_agent" {
  ami                    = var.ami
  instance_type          = var.jenkins_agent
  key_name               = "raj-ankit"
  vpc_security_group_ids = [aws_security_group.main_sg.id]
  tags = {
    Name = "jenkins-agent"
  }
}

resource "aws_instance" "ansible_server" {
  ami                    = var.ami
  instance_type          = var.ansible_server
  key_name               = "raj-ankit"
  vpc_security_group_ids = [aws_security_group.main_sg.id]
  tags = {
    Name = "ansible-server"
  }
}

