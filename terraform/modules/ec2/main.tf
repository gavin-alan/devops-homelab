data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_key_pair" "main" {
  key_name   = "${var.project_name}-key"
  public_key = file(pathexpand(var.ssh_public_key_path))
}

resource "aws_instance" "main" {
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = aws_key_pair.main.key_name
  iam_instance_profile        = var.instance_profile_name

  tags = {
    Name    = "${var.project_name}-server"
    Project = var.project_name
  }
}

resource "aws_eip" "main" {
  instance = aws_instance.main.id
  domain   = "vpc"
  tags = {
    Name    = "${var.project_name}-eip"
    Project = var.project_name
  }
}
