resource "tls_private_key" "dev_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.generated_key_name
  public_key = tls_private_key.dev_key.public_key_openssh
}

resource "local_file" "private_key" {
  content         = tls_private_key.dev_key.private_key_pem
  filename        = "${var.save_path}/${var.generated_key_name}.pem"
  file_permission = "0400"
}