// Create a GCE instance
resource "google_compute_instance" "gcp-gce-instance" {
  name         = "multi-cloud-gce-instance"
  machine_type = "f1-micro"
  zone         = "southamerica-east1-c"

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