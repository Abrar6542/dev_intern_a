resource "aws_security_group" "devops_sg" {
  name        = "devops-assignment-sg"
  description = "Allow SSH and app ports"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#-------EC2 Recource----->

resource "aws_instance" "devops_ec2" {
  ami           = "ami-0030e4319cbf4dbf2"       # Ubuntu 22.04(us-east-1)
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  user_data =  <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y docker.io
              systemctl start docker
              systemctl enable docker
              EOF

  tags = {
    Name = "DevOps-Assignment_Terraform"
  }
}
