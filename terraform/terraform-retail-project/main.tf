module "digitalocean-infra" {
  source = "../modules/digitalocean-infra"

  do_token = var.do_token

  project-name = "retail-app"
  region = "ams3"
  server-count = 0

  vpc-ip-range = "10.10.10.0/24"

  ssh-key = file("./files/id_rsa.pub")
}
