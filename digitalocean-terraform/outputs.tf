output "my-server-public-ip" {
  value = digitalocean_droplet.my-server.ipv4_address
}

output "my-server-private-ip" {
  value = digitalocean_droplet.my-server.ipv4_address_private
  sensitive = true
}