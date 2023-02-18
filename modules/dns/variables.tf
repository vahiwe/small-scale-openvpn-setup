variable "domain_name" {
  description = "The domain name of the hosted zone"
  type        = string
}

variable "subdomain" {
  description = "The subdomain for the record"
  type        = string
}

variable "server_ip" {
  description = "The IP address of the server"
  type        = string
}