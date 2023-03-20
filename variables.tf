variable "hcloud_token" {
  type        = string
  description = "Hetzner Cloud API Token"
}

variable "cluster_name" {
  type        = string
  description = "Name of the cluster"
}

variable "ip_range" {
  type        = string
  description = "IP range for the subnet"
}

variable "network_zone" {
  type        = string
  description = "Network zone to use for the subnet"
}

variable "ssh_key_fingerprint" {
  type        = string
  description = "Fingerprint of the SSH key to use"
}