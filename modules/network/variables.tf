variable "vpc_cidr" {
  description = "VPC CIDR Block"
  #default = "10.100.0.0/16"

}

variable "public_subnet_cidr" {
  description = "Public Subnet CIDR"
  #default = "10.100.1.0/24"

}

variable "private_subnet_cidr" {
  description = "Private Subnet CIDR"
  #default = "10.100.3.0/24"
}

variable "region_location" {
  description = "Selected Region"
  
}