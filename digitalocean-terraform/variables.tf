variable "do_token" {
  sensitive = true
}

variable "droplets" {
  description = "Map of droplet configurations"
  type = map(object({
    image = optional(string, "ubuntu-22-04-x64")
    name = string
    region = optional(string, "ams3")
    size = optional(string, "s-2vcpu-4gb")
    vpc_uuid = optional(string)
  }))
}