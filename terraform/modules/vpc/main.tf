# ====================================================================
# 1. Create VPC
# ====================================================================

resource "aws_vpc" "swo_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.environment}-swo-vpc"
    environment = "${var.environment}"
  }
}

# ====================================================================
# 2. Create Public Subnets
# ====================================================================

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.swo_vpc.id
  cidr_block              = var.public_subnet_cidr[0]
  availability_zone       = var.public_subnet_az[0]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.environment}-public-subnet-1"
    environment = "${var.environment}"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.swo_vpc.id
  cidr_block              = var.public_subnet_cidr[1]
  availability_zone       = var.public_subnet_az[1]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.environment}-public-subnet-2"
    environment = "${var.environment}"
  }
}

# ====================================================================
# 3. Create Internet Gateway
# ====================================================================

resource "aws_internet_gateway" "swo_igw" {
  vpc_id = aws_vpc.swo_vpc.id

  tags = {
    Name        = "${var.environment}-swo-igw"
    environment = "${var.environment}"
  }
}

# ====================================================================
# 4. Create route tables and associates
# ====================================================================

resource "aws_route_table" "swo_public_rt" {
  vpc_id = aws_vpc.swo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.swo_igw.id
  }

  tags = {
    Name        = "${var.environment}-swo-public-rt"
    environment = "${var.environment}"
  }
}

resource "aws_route_table_association" "swo_public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.swo_public_rt.id
}

resource "aws_route_table_association" "swo_public_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.swo_public_rt.id
}

# ====================================================================
# 5. Create Security Group (AWS Well-Architected Framework - Security Pillar)
# ====================================================================

resource "aws_security_group" "swo_sg" {
  vpc_id      = aws_vpc.swo_vpc.id
  description = "Allow inbound global traffic and restrict SSH access"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.ingres_cidr_block]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.egress_cidr_block]
  }

  tags = {
    Name        = "${var.environment}-swo-sg"
    environment = "${var.environment}"
  }
}


