#Provider
provider "aws" {
	region = var.region
	access_key = "${var.AWS_ACCESS_KEY}"
	secret_key = "${var.AWS_SECRET_KEY}"
}

#Module
module "myvpc" {
    source = "../vpcmodule/"
}

#Resource key pair
resource "aws_key_pair" "levelup_key" {
  key_name      = "levelup_key"
  public_key    = file(var.public_key_path)
}

#EC2 Instance
resource "aws_instance" "levelup_instance" {
  count = 3
  ami                       = var.instance_ami
  instance_type             = var.instance_type
  subnet_id                 = module.myvpc.public_subnet_id
  vpc_security_group_ids    = module.myvpc.sg_all_id
  key_name                  = aws_key_pair.levelup_key.key_name

  tags = {
		Name         = "ansible-client-${count.index}"
	}
}
