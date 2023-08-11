#  Region
# Configure the Provider
provider "aws" {
  region = var.region_location
}

#  EC2
resource "aws_instance" "web" {
  count = var.instance_count
  subnet_id     = var.app_subnet_id
  ami           = var.image_type
  instance_type = var.instance_types

tags = {
    Name = "Ec2-0${count.index + 1}"
  }

}