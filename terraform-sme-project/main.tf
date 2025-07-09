module "digitalocean-infra" {
  source = "../modules/digitalocean-infra"

  do_token = var.do_token

  project-name = "sme-app"
  region = "nyc3"

  vpc-ip-range = "10.10.11.0/24"

  ssh-key = file("./files/id_rsa.pub")
}