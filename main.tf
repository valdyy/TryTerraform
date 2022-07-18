provider "google" {
    project = "terraformvaldy"
    region = "asia-southeast2"
    credentials = "c:users/sekolah/Downloads/terraformvaldy-6cc71a438da0.json"
}

resource "google_compute_network" "custom_vpc" {
  name = "custom-vpc"  
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "asia_southeast_subnet" {
    name = "asia-southeast-subnet"
    ip_cidr_range = "10.0.0.0/27"
    network = google_compute_network.custom_vpc.id
    region = "asia-southeast2"
}

resource "google_compute_subnetwork" "europe_subnet" {
    name = "europe-subnet"
    ip_cidr_range = "10.0.10.0/27"
    network = google_compute_network.custom_vpc.id
    region = "europe-central2"
}

resource "google_compute_firewall" "custom_allow_http" {
  name    = "custom-allow-http"
  network = google_compute_network.custom_vpc.id
  
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = [ "0.0.0.0/0" ]
  source_tags = ["http-server"]
}

resource "google_compute_firewall" "custom_allow_ssh" {
  name    = "custom-allow-ssh"
  description = "Allow SSH from anywhere"
  network = google_compute_network.custom_vpc.id
  
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = [ "0.0.0.0/0" ]
}
