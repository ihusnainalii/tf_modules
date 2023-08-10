variable "region_location" {
    description = "Region Selection"
  
}

variable "instance_count" {
  description = "Number of Ec2 Instances"
  type        = number
  default=1
}
variable "instance_types" {
  description = "Instance Type"
  default     = "t2.micro"
}

variable "image_type" {
  description = "Instance Type"
  default     = "ami-0557a15b87f6559cf"
}

variable "app_subnet_id" {type = string}