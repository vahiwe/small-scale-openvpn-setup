variable "key_name" {
  type        = string
  description = "Name of the key-pair to use"
}

variable "instance_type" {
  type        = string
  default     = "t2.small"
  description = "Type of instance to launch"
}

variable "ami_alias" {
  type        = string
  description = "Alias of the AMI to use"
}

variable "server_ports_protocol" {
  type = map(list(number))
  default = {
    "tcp" = [22, 80, 443]
    "udp" = [53]
  }
}