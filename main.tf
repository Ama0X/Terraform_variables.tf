resource "aws_vpc" "Ama_VPC" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.vpc_tenancy
  enable_dns_hostnames = var.vpc_dns

  tags = {
    Name = "Ama_VPC"
  }
}

# public subnet 1
resource "aws_subnet" "Prod-pub-sub1" {
  vpc_id     = aws_vpc.Ama_VPC.id
  cidr_block = var.Prod-pub-sub1_cidr

  tags = {
    Name = "Prod-pub-sub1"
  }
}

# public subnet 2
resource "aws_subnet" "Prod-pub-sub2" {
  vpc_id     = aws_vpc.Ama_VPC.id
  cidr_block = var.Prod-pub-sub2_cidr

  tags = {
    Name = "Prod-pub-sub2"
  }
}

# private subnet 1
resource "aws_subnet" "Prod-priv-sub1" {
  vpc_id     = aws_vpc.Ama_VPC.id
  cidr_block = var.Prod-priv-sub1_cidr

  tags = {
    Name = "Prod-priv-sub1"
  }
}

# private subnet 2
resource "aws_subnet" "Prod-priv-sub2" {
  vpc_id     = aws_vpc.Ama_VPC.id
  cidr_block = var.Prod-priv-sub2_cidr

  tags = {
    Name = "Prod-priv-sub2"
  }
}

# aws public route table 
resource "aws_route_table" "Prod-pub-route-table" {
  vpc_id = aws_vpc.Ama_VPC.id

  tags = {
    Name = "Prod-pub-route-table"
  }
}

# aws private route table 
resource "aws_route_table" "Prod-priv-route-table" {
  vpc_id = aws_vpc.Ama_VPC.id

  tags = {
    Name = "Prod-priv-route-table"
  }
}

# aws public route association 1
resource "aws_route_table_association" "pub-route-table-association-1" {
  subnet_id      = aws_subnet.Prod-pub-sub1.id
  route_table_id = aws_route_table.Prod-pub-route-table.id
}

# aws public route association 2
resource "aws_route_table_association" "pub-route-table-association-2" {
  subnet_id      = aws_subnet.Prod-pub-sub2.id
  route_table_id = aws_route_table.Prod-pub-route-table.id
}

# aws private route association 1
resource "aws_route_table_association" "priv-route-table-association-1" {
  subnet_id      = aws_subnet.Prod-priv-sub1.id
  route_table_id = aws_route_table.Prod-priv-route-table.id
}

# aws private route association 2
resource "aws_route_table_association" "priv-route-table-association-2" {
  subnet_id      = aws_subnet.Prod-priv-sub2.id
  route_table_id = aws_route_table.Prod-priv-route-table.id
}

# aws IGW
resource "aws_internet_gateway" "Prod-igw" {
  vpc_id = aws_vpc.Ama_VPC.id

  tags = {
    Name = "Prod-igw"
  }
}

# aws route for IGW & pub route table
resource "aws_route" "Prod-igw-association" {
  route_table_id            = aws_route_table.Prod-pub-route-table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.Prod-igw.id
}
# create Elastic IP Address
resource "aws_eip" "Prod-eip" {
tags = {
Name = "Prod-eip"
}
}

# create NAT Gateway
resource "aws_nat_gateway" "Prod-Nat-gateway" {
allocation_id = aws_eip.Prod-eip.id
subnet_id = aws_subnet.Prod-pub-sub1.id
tags = {
Name = "Prod-Nat-gateway"
}
}

# NAT associate with priv route
resource "aws_route" "Prod-Nat-association" {
route_table_id = aws_route_table.Prod-priv-route-table.id
gateway_id = aws_nat_gateway.Prod-Nat-gateway.id
destination_cidr_block = "0.0.0.0/0"
}
