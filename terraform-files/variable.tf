variable "region" {
  default = "us-east-1"
}

variable "ami" {
  default = "ami-020cba7c55df1f615" # Ubuntu in us-east-1
}


variable "jenkins_master" {
  default = "t2.medium"
}

variable "jenkins_agent" {
  default = "t2.medium"
}

variable "ansible_server" {
  default = "t2.micro"
}

