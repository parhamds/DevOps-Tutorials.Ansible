# Variables
variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  default = "10.1.0.0/16"
}

variable "cidr_subnet" {
  description = "CIDR block for the subnet"
  default = "10.1.0.0/24"
}

variable "availability_zone" {
  description = "availability zone to create subnet"
  default = "eu-north-1a"
}

variable "environment_tag" {
  description = "Environment tag"
  default = "Production"
}
