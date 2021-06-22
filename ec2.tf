data "aws_ami" "packer_ami" {
  most_recent = true

  owners = ["self"]

  filter {
    name   = "name"
    values = ["iac-ubuntu-v0.3*"]
  }
}

# Web servers
resource "aws_instance" "my_ec2_webserver_cluster" {
  for_each = var.webserver_instances

  ami           = data.aws_ami.packer_ami.id
  key_name      = aws_key_pair.my_key_pair.key_name
  instance_type = lookup(each.value, "instance_type", "t2.micro")

  vpc_security_group_ids = [aws_security_group.my_public_sg.id]

  subnet_id = lookup(aws_subnet.my_public_subnet,
    var.public_subnets[0],
    var.public_subnets[0]
  ).id

  associate_public_ip_address = true
  monitoring                  = lookup(each.value, "monitoring", true)

  tags = {
    Name   = lookup(each.value, "instance_name", each.key)
    Deploy = "Terraform"
  }

  depends_on = [aws_key_pair.my_key_pair]
}

# Monitoring servers
resource "aws_instance" "my_ec2_monitoring_cluster" {
  for_each = var.monitoring_instances

  ami           = data.aws_ami.packer_ami.id
  key_name      = aws_key_pair.my_key_pair.key_name
  instance_type = lookup(each.value, "instance_type", "t2.micro")

  vpc_security_group_ids = [aws_security_group.my_private_sg.id]

  subnet_id = lookup(aws_subnet.my_private_subnet,
    var.private_subnets[0],
    var.private_subnets[0]
  ).id

  monitoring = lookup(each.value, "monitoring", true)

  tags = {
    Name   = lookup(each.value, "instance_name", each.key)
    Deploy = "Terraform"
  }

  depends_on = [aws_key_pair.my_key_pair]
}

# Database servers
resource "aws_instance" "my_ec2_database_cluster" {
  for_each = var.database_instances

  ami           = data.aws_ami.packer_ami.id
  key_name      = aws_key_pair.my_key_pair.key_name
  instance_type = lookup(each.value, "instance_type", "t2.micro")

  vpc_security_group_ids = [aws_security_group.my_intra_sg.id]

  subnet_id = lookup(aws_subnet.my_intra_subnet,
    var.intra_subnets[0],
    var.intra_subnets[0]
  ).id

  monitoring = lookup(each.value, "monitoring", true)

  tags = {
    Name   = lookup(each.value, "instance_name", each.key)
    Deploy = "Terraform"
  }

  depends_on = [aws_key_pair.my_key_pair]
}
