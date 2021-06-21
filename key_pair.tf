resource "aws_key_pair" "my_key_pair" {
  key_name   = "tf_key"
  public_key = file(var.my_key_file)
}
