resource "google_compute_instance" "terraform" {
  project      = "your_project_id"
  name         = "terraform"
  machine_type = "e2-medium"
  zone         = "europe-west1-d"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}