# Create a new Web Droplet in the nyc2 region
resource "digitalocean_droplet" "app-server" {
  for_each = var.droplets

  image   = each.value.image
  name    = each.value.name
  region  = each.value.region
  size    = each.value.size
  vpc_uuid = each.value.region == "ams3" && each.value.vpc_uuid == null ? digitalocean_vpc.app-server-vpc.id : each.value.vpc_uuid
}

resource "digitalocean_vpc" "app-server-vpc" {
  name     = "app-server-vpc"
  region   = "ams3"
  ip_range = "10.10.10.0/24"
}
