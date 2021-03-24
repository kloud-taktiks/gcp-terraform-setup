variable "regions" {
  description = "GCP region identifier"
  type        = list
}

variable "zones" {
  description = "GCP zone identifier"
  type        = list
}

variable "project_id" {
  description = "Project ID"
  type        = string
}

variable "subnetwork_name" {
  description = "Subnetwork name"
  type        = string
}

variable "network_name" {
  description = "Network name"
  type        = string
}

variable "machine_type" {
  description = " the machine type to create"
  default     = "MACHINE_TYPE"
}