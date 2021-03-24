## Create custom VPC and subnet
module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~>2.4"

  project_id              = var.project_id
  network_name            = var.network_name
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = "false"

  subnets = [
    {
      subnet_name           = var.subnetwork_name
      subnet_ip             = "10.0.0.0/27"
      subnet_region         = var.regions[0]
      subnet_private_access = "true"
      subnet_flow_logs      = "false"

    }
  ]

  routes = []
}

##Create a service account that will be attached to GCE instance
resource "google_service_account" "web-sa" {
  account_id   = "web-sa"
  display_name = "web-sa"
}

##Create GCE instance
resource "google_compute_instance" "web-instance" {
  name         = "web1"
  machine_type = var.machine_type
  zone         = var.zones[0]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
    device_name = boot
    auto_delete = true

  }

  network_interface {
    network    = module.vpc.network_self_link
    subnetwork = var.subnetwork_name
    access_config {

    }
  }

  labels = {
    os = "linux"
  }

  tags = ["web"]

  service_account {
    email  = google_service_account.web-sa.email
    scopes = ["cloud-platform"]
  }

}
