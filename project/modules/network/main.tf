# 2- Region
# Configure the AWS Provider
provider "aws" {
  region = var.region_location
}

# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

# 3- Create VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "Tutorial VPC"
  }
}

# 4- Create Subnets


resource "aws_subnet" "public_sb" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "public-subnet01"
  }
}


resource "aws_subnet" "private_sb" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "private-subnet01"
  }
}

# 5- Create Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "InternetGW"
  }
}

# 6- Create Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Public_RT"
  }
}
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "Private_RT"
  }
}

# 7- Create Route association
resource "aws_route_table_association" "public_rt_a" {
  subnet_id      = aws_subnet.public_sb.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_rt_a" {
  subnet_id      = aws_subnet.private_sb.id
  route_table_id = aws_route_table.private_rt.id
}
# 8- Create EIP
resource "aws_eip" "eip_nat_gw" {
  vpc = true
}

# 9- Create Nat GW
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.eip_nat_gw.id
  subnet_id     = aws_subnet.private_sb.id

  tags = {
    Name = "Nat_GW01"
  }
  depends_on = [aws_internet_gateway.gw]
}

