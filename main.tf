##################################################
# Provider Configuration
##################################################
provider "aws" {
  region = "us-east-1"
}

##################################################
# Security Group - allows SSH (22) and HTTP (80)
##################################################
resource "aws_security_group" "web_sg" {
  name        = "web_server_sg"
  description = "Allow SSH and HTTP access"

  # Allow SSH access
  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP access (for web app)
  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "TerraformWebSecurityGroup"
  }
}

##################################################
# EC2 Instance
##################################################
resource "aws_instance" "web_server" {
  ami                    = "ami-0601422bf6afa8ac3" # Amazon Linux 2 (Free Tier)
  instance_type          = "t3.micro"              # Free Tier eligible
  key_name               = "Network"               # Your AWS key pair name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # Run commands when the instance starts
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y python3
              EOF

  tags = {
    Name = "TerraformWebServer"
  }
}
