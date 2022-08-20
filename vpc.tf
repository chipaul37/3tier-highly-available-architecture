resource "aws_vpc" "vpc" {
    cidr_block           = var.vpc_cidr
    instance_tenancy     = "default"
    enable_dns_hostnames = true

    tags = {
        name = "dev vpc"
        
    }
}
resource "aws_internet_gateway" "internet_gateway" {
    vpc_id   = aws_vpc.vpc.id

    tags = {
        name = "dev internet gateway"
    }
}

resource "aws_subnet" "public_subnet_az1" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = var.public_subnet_az1_cidr
    availability_zone        = "us-east-1a"
    map_public_ip_on_launch = true

    tags = { 
        name = "public subnet az1"
    }
}

resource "aws_subnet" "public_subnet_az2" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = var.public_subnet_az2_cidr
    availability_zone       = "us-east-1b" 
    map_public_ip_on_launch = true

    tags = { 
        name = "public subnet az2"
    }
}

resource "aws_route_table" "public_route_table" {
    vpc_id         = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway.id
    }
    tags = {
        name = "public_route_table"
    }
}

resource "aws_route_table_association" "public_subnet_az1" {
    subnet_id      = aws_subnet.public_subnet_az1.id
    route_table_id = aws_route_table.public_route_table.id 
}

resource "aws_route_table_association" "public_subnet_az2" {
    subnet_id      = aws_subnet.public_subnet_az2.id
    route_table_id = aws_route_table.public_route_table.id 
}

resource "aws_subnet" "private_app_subnet_az1" {
    vpc_id            = aws_vpc.vpc.id
    cidr_block        = var.private_app_subnet_az1_cidr
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = false
    
    tags = {
        name = "private subnet az1"
    }
}
resource "aws_subnet" "private_app_subnet_az2" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = var.private_app_subnet_az2_cidr
    availability_zone       = "us-east-1b"
    map_public_ip_on_launch = false
    
    tags = {
        name = "private app subnet az2"
    }
}

resource "aws_subnet" "private_data_subnet_az1" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = var.private_data_subnet_az1_cidr
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = false
    
    tags = {
        name = " private data subnet az1"
    }
}

resource "aws_subnet" "private_data_subnet_az2" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = var.private_data_subnet_az2_cidr
    availability_zone       = "us-east-1b"
    map_public_ip_on_launch = false
    
    tags = {
        name = "private data subnet az2"
    }
}