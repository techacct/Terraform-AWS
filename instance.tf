resource "aws_instance" "public" {
  ami                                = "ami-02396cdd13e9a1257"
  associate_public_ip_address        = true
  instance_type                      = "t3.micro"
  key_name                           = "mykey"
  vpc_securityvpc_security_group_ids = [aws_security_group.public]
  subnet_id                          = aws_subnet.public[0].id

  tags = {
    Name = "${var.env_code}-public"
  }
}

resource "aws_security_group" "public" {
  name        = "${var.env_code}-public"
  description = "Allow inbound traffic"
  vpc_id        = aws_vpc.main.id

  ingress = {
    description = "SSH from public"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks  = ["41.79.5.2/32"]
  }

  egress = {
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env_code}-public"
  }
}
