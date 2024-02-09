resource "aws_security_group" "public_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public_sg"
  }
}

resource "aws_security_group" "private_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.public_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private_sg"
  }
}

resource "aws_key_pair" "deployer_key" {
  key_name   = "hestio-terraform-ec2-key"
  public_key = file("${path.module}/hestio-terraform-ec2-key.pub")
}

data "aws_ssm_parameter" "recommended_ami" {
    name = "/aws/service/ecs/optimized-ami/amazon-linux-2023/recommended/image_id"
}

resource "aws_instance" "public_instance" {
  ami           = data.aws_ssm_parameter.recommended_ami.value
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  key_name      = aws_key_pair.deployer_key.key_name

  tags = {
    Name = "public-instance-${terraform.workspace}"
  }

  provisioner "file" {
    source      = "${path.module}/hestio-terraform-ec2-key"
    destination = "/home/ec2-user/hestio-terraform-ec2-key"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("${path.module}/hestio-terraform-ec2-key")
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/ec2-user/hestio-terraform-ec2-key"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("${path.module}/hestio-terraform-ec2-key")
      host        = self.public_ip
    }
  }
}

resource "aws_instance" "private_instance" {
  ami           = data.aws_ssm_parameter.recommended_ami.value
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  key_name      = aws_key_pair.deployer_key.key_name

  tags = {
    Name = "private-instance-${terraform.workspace}"
  }
}
