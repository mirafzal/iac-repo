resource "digitalocean_droplet" "my-server" {
  image   = "ubuntu-22-04-x64"
  name    = "my-server"
  region  = "ams3"
  size    = "s-1vcpu-1gb"
}

