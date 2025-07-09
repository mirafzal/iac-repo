resource "digitalocean_vpc" "app-server-vpc" {
  name     = "${var.project-name}-vpc"
  region   = var.region
  ip_range = var.vpc-ip-range
}

resource "digitalocean_ssh_key" "app-server-ssh-key" {
  name       = "${var.project-name}-ssh-key"
  public_key = var.ssh-key
}

resource "digitalocean_droplet" "app-server" {
  count = var.server-count

  image   = "ubuntu-22-04-x64"
  name    = "${var.project-name}-server-${count.index}"
  region  = var.region
  size    = "s-1vcpu-1gb"
  vpc_uuid = digitalocean_vpc.app-server-vpc.id

  ssh_keys = [digitalocean_ssh_key.app-server-ssh-key.id]
}

resource "digitalocean_loadbalancer" "app-server-lb" {
  name   = "${var.project-name}-load-balancer"
  region = var.region
  vpc_uuid = digitalocean_vpc.app-server-vpc.id

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 80
    target_protocol = "http"
  }

  healthcheck {
    port     = 22
    protocol = "tcp"
  }

  droplet_ids = [
    for droplet in digitalocean_droplet.app-server : droplet.id
  ]
}

