terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
variable "do_token" {}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

# Create a new SSH key
resource "digitalocean_ssh_key" "project_2_key" {
  name       = "project_2_key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFCuXB0GcyCJ/3VZd/xbbTeg8k54n5nLgTrXTxaJWuMK kimang@KIMs-MacBook-Pro.local"
}

# Create a new Web Droplet in the nyc2 region
resource "digitalocean_droplet" "project_2" {
  image  = "ubuntu-22-04-x64"
  name   = "project-2"
  region = "sgp1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [digitalocean_ssh_key.project_2_key.fingerprint]
}

output p2_host {
  value       = digitalocean_droplet.project_2.ipv4_address
  description = "IPV4 of P2 Droplet"
}
