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
resource "digitalocean_droplet" "app-server" {
  image   = "ubuntu-22-04-x64"
  name    = "my-app-server-123"
  region  = "nyc3"
  size    = "s-2vcpu-4gb"
  backups = true
  backup_policy {
    plan    = "weekly"
    weekday = "TUE"
    hour    = 8
  }
}

# resource "digitalocean_vpc" "my-nyc3-network" {
#   name     = "my-nyc3-network"
#   region   = "nyc3"
#   ip_range = "10.10.10.0/24"
# }

resource "digitalocean_droplet" "app-server-2" {
  image   = "ubuntu-22-04-x64"
  name    = "app-server2"
  region  = "ams3"
  size    = "s-2vcpu-2gb"
  backups = true
  monitoring = true
}