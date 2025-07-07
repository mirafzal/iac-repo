resource "digitalocean_vpc" "app-server-vpc" {
  name     = "app-server-vpc"
  region   = "ams3"
  ip_range = "10.10.10.0/24"
}

resource "digitalocean_droplet" "app-server" {
  for_each = var.droplets

  image   = each.value.image
  name    = each.value.name
  region  = each.value.region
  size    = each.value.size
  ssh_keys = [digitalocean_ssh_key.default-ssh-key.id]
  vpc_uuid = each.value.region == "ams3" && each.value.vpc_uuid == null ? digitalocean_vpc.app-server-vpc.id : each.value.vpc_uuid
}

resource "digitalocean_ssh_key" "default-ssh-key" {
  name       = "default-ssh-key"
  public_key = file("./files/id_rsa.pub")
}

resource "digitalocean_loadbalancer" "app-server-lb" {
  name   = "app-server-lb"
  region = "ams3"

  vpc_uuid = digitalocean_vpc.app-server-vpc.id

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 80
    target_protocol = "http"
  }

  healthcheck {
    port     = 80
    protocol = "tcp"
  }

  droplet_ids = [
    for d in digitalocean_droplet.app-server :
    d.id if d.region == "ams3" && d.vpc_uuid == digitalocean_vpc.app-server-vpc.id
  ]
}