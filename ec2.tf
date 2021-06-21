data "aws_ami" "packer_ami" {
  most_recent = true

  owners = ["self"]

  filter {
    name   = "name"
    values = ["iac-ubuntu-v0.3*"]
  }
}

# Get subnet index number to randomly calculate subnet id
# for an instance
resource "random_integer" "subnet_index" {
  min = 0
  max = length(var.public_subnets) - 1
}

resource "aws_instance" "my_ec2_web_server_cluster" {
  ami           = data.aws_ami.packer_ami.id
  key_name      = aws_key_pair.my_key_pair.key_name
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.my_public_sg.id]

  subnet_id = lookup(aws_subnet.my_public_subnet,
    var.public_subnets[random_integer.subnet_index.result],
    var.public_subnets[0]
  ).id

  associate_public_ip_address = true

  tags = {
    Name   = "my_ec2_web_server_cluster"
    Deploy = "Terraform"
  }

  depends_on = [aws_key_pair.my_key_pair]
}
