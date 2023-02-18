locals {
  server_ports = flatten([
    for protocol, ports in var.server_ports_protocol : [
      for port in ports : {
        protocol = protocol
        port     = port
      }
    ]
  ])
  all_ips = ["0.0.0.0/0"]
}

data "aws_ssm_parameter" "ami_id" {
  name = var.ami_alias
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_eip" "elastic_ip" {
  vpc      = true
  instance = aws_instance.web.id
}

resource "aws_instance" "web" {
  ami                    = data.aws_ssm_parameter.ami_id.value
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  tags = {
    "Name" = "OPENVPN-Server"
  }
}

resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Manage inbound traffic to the web server"
  vpc_id      = data.aws_vpc.default.id
}

resource "aws_security_group_rule" "ingress_rules" {
  for_each          = { for idx, port in local.server_ports : idx => port }
  security_group_id = aws_security_group.web_sg.id
  type              = "ingress"
  from_port         = each.value.port
  to_port           = each.value.port
  protocol          = each.value.protocol
  cidr_blocks       = local.all_ips
}