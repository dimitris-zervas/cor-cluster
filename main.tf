terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.36.2"
    }
  }
}

# Define Hetzner provider token
provider "hcloud" {
  token = var.hcloud_token
}

# Obtain ssh key data
data "hcloud_ssh_key" "ssh_key" {
  fingerprint = var.ssh_key_fingerprint
}

# Virtaul network
resource "hcloud_network" "vnet" {
  name     = "${var.cluster_name}_vnet"
  ip_range = var.ip_range
}

# Default subnet
resource "hcloud_network_subnet" "subnet" {
  network_id   = hcloud_network.vnet.id
  type         = "server"
  network_zone = var.network_zone
  ip_range     = var.ip_range
}

# Control Plane node
resource "hcloud_server" "control_plane_node" {
  name        = "control-plane-1"
  image       = "ubuntu-22.04"
  server_type = "cx21"
  location    = "nbg1"
  ssh_keys = [
    data.hcloud_ssh_key.ssh_key.id
  ]
}

# Worker node 1
resource "hcloud_server" "worker_node_1" {
  name        = "worker-1"
  location    = "nbg1"
  image       = "ubuntu-22.04"
  server_type = "cx21"
  ssh_keys = [
    data.hcloud_ssh_key.ssh_key.id
  ]
}

# Worker node 2
resource "hcloud_server" "worker_node_2" {
  name        = "worker-2"
  location    = "nbg1"
  image       = "ubuntu-22.04"
  server_type = "cx21"
  ssh_keys = [
    data.hcloud_ssh_key.ssh_key.id
  ]
}

# Worker node 3
resource "hcloud_server" "worker_node_3" {
  name        = "worker-3"
  location    = "nbg1"
  image       = "ubuntu-22.04"
  server_type = "cx21"
  ssh_keys = [
    data.hcloud_ssh_key.ssh_key.id
  ]
}

# Place Control Plane node to subnet
resource "hcloud_server_network" "control_plane_to_subnet" {
  server_id = hcloud_server.control_plane_node.id
  subnet_id = hcloud_network_subnet.subnet.id
}

# Place Worker nodes to subnet

resource "hcloud_server_network" "worker1_to_subnet" {
  server_id = hcloud_server.worker_node_1.id
  subnet_id = hcloud_network_subnet.subnet.id
}

resource "hcloud_server_network" "worker2_to_subnet" {
  server_id = hcloud_server.worker_node_2.id
  subnet_id = hcloud_network_subnet.subnet.id
}

resource "hcloud_server_network" "worker3_to_subnet" {
  server_id = hcloud_server.worker_node_3.id
  subnet_id = hcloud_network_subnet.subnet.id
}


resource "local_file" "inventory" {
  content  = templatefile("${path.module}/inventory.tftpl", { 
    master_ip_addrs = [hcloud_server.control_plane_node.ipv4_address]
    workers_ip_addrs = [
      hcloud_server.worker_node_1.ipv4_address,
      hcloud_server.worker_node_2.ipv4_address,
      hcloud_server.worker_node_3.ipv4_address
    ]
  })
  filename = "${path.module}/ansible/hosts"
}