# Configure VPC
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}

# Configure subnets
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"
}

# Configure Network ACLs
resource "aws_network_acl" "public" {
  vpc_id = aws_vpc.example.id

  # Allow HTTP traffic from any IP address
  ingress {
    rule_number = 100
    protocol    = "tcp"
    action      = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 80
    to_port     = 80
  }

  # Deny all traffic from a specific IP address range
  ingress {
    rule_number = 200
    protocol    = "all"
    action      = "deny"
    cidr_block  = "10.0.2.0/24"
  }

  # Allow all traffic within the public subnet
  ingress {
    rule_number = 300
    protocol    = "all"
    action      = "allow"
    cidr_block  = aws_subnet.public.cidr_block
  }

  # Allow all outbound traffic
  egress {
    rule_number = 100
    protocol    = "all"
    action      = "allow"
    cidr_block  = "0.0.0.0/0"
  }
}

resource "aws_network_acl" "private" {
  vpc_id = aws_vpc.example.id

  # Deny all inbound traffic
  ingress {
    rule_number = 100
    protocol    = "all"
    action      = "deny"
    cidr_block  = "0.0.0.0/0"
  }

  # Allow all outbound traffic
  egress {
    rule_number = 100
    protocol    = "all"
    action      = "allow"
    cidr_block  = "0.0.0.0/0"
  }
}

# Configure Security Groups
resource "aws_security_group" "public" {
  name        = "public-sg"
  description = "Security group for public subnet"
  vpc_id      = aws_vpc.example.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private" {
  name        = "private-sg"
  description = "Security group for private subnet"
  vpc_id      = aws_vpc.example.id

  # Allow all inbound traffic from the public subnet
  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    security_groups  = [aws_security_group.public.id]
  }

  # Allow outbound traffic to the public subnet and internet
  egress {
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = [aws_subnet.public.cidr_block, "0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 65535
    protocol         = "udp"
    cidr_blocks      = [aws_subnet.public.cidr_block, "0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 65535
    protocol         = "icmp"
    cidr_blocks      = [aws_subnet.public.cidr_block, "0.0.0.0/0"]
  }
}
