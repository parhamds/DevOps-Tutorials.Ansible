variable "region" {
  default = "eu-north-1"
}

variable "AWS_ACCESS_KEY" {
  default = "AKIA4EF4JNMSEBFJOFNU"
}

variable "AWS_SECRET_KEY" {
  default = "PBOqjcVwRolFtisZKChpIkD2jEkcwIyf/hIc4ISL"
}

variable "public_key_path" {
  description = "Public key path"
  default = "../ansible-srv.pub"
}

variable "instance_ami" {
  description = "AMI for aws EC2 instance"
  default = "ami-0f926b5ee133399f0"
}

variable "instance_type" {
  description = "type for aws EC2 instance"
  default = "t3.micro"
}

variable "environment_tag" {
  description = "Environment tag"
  default = "Production"
}
