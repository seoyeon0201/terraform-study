// Configure the Google Cloud provider
provider "google" {
 credentials = "${file("gcp-credentials.json")}"
 project     = "terraform-gcp-437815"
 region      = "us-central1"
}

// Create a GCE instance
resource "google_compute_instance" "default" {
  name         = "terraform"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}