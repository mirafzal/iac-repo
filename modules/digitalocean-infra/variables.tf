variable "do_token" {
  sensitive = true
}

variable "project-name" {}
variable "region" {
  default = "ams3"
}
variable "server-count" {
  default = 1
}
variable "vpc-ip-range" {}
variable "ssh-key" {}