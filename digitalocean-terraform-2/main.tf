terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = ""
}

# Create a new Web Droplet in the nyc2 region
resource "digitalocean_droplet" "my-vm" {
  image   = "ubuntu-22-04-x64"
  name    = "my-vm"
  region  = "ams3"
  size    = "s-2vcpu-2gb"
  backups = true
  backup_policy {
    plan    = "weekly"
    weekday = "TUE"
    hour    = 8
  }
}

# resource "digitalocean_vpc" "example" {
#   name     = "example-project-network"
#   region   = "nyc3"
#   ip_range = "10.10.10.0/24"
# }