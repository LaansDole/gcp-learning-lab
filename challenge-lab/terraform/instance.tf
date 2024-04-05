# This code is compatible with Terraform 4.25.0 and versions that are backwards compatible to 4.25.0.
# For information about validating this Terraform code, see https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build#format-and-validate-the-configuration
# This is the configuration for GCP Cloud API access

resource "google_compute_instance" "medvoice-demo-instance-20240405-070911" {
  boot_disk {
    auto_delete = true
    device_name = "medvoice-demo-instance"

    initialize_params {
      image = "projects/debian-cloud/global/images/debian-12-bookworm-v20240312"
      size  = 10
      type  = "pd-balanced"
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  labels = {
    goog-ec-src = "vm_add-tf"
  }

  machine_type = "e2-standard-2"

  metadata = {
    ssh-keys = "laansday:ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBPk9BrMt9CPf9uT2c0z0c2uPSqy+kB5Ufy3dw08QH1fX42NYyGmAG1OjBezfvZbNIUtF0tieJ6Sm2iN2T8BCj1c= google-ssh {\"userName\":\"laansday@gmail.com\",\"expireOn\":\"2024-04-04T06:24:17+0000\"}\nlaansday:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCmegTHASXb/EGq602LYlr/rAVzGapwCZ2xMtoam1afzrJd19HKTN7zN0qN+vw821CSwBGpqbudgf8efa1ZE8ZK+k8oUX8u88npXDR1eae6coZuJ3FIucqiQHWgJ2cfZWN6p5PdLtIbzTz98fy8LmsjaTHMWdyn6SFFH0p0+0r9AIjUV+/aSvypImvYUoKIUdKuR7HkgV7cR00Qfu5i28c+dmlN7+Glz6QFlIquAvhWJjGtUYHAwV2Lw4nYTgAf71gaoltagrgaU6LV5b+9mVmCbix5YPHYzLMZaLyXyaWnWtn+ri+IjLyHPCmiygStCo/eHnb5axUN3XD/dYGX0c8D google-ssh {\"userName\":\"laansday@gmail.com\",\"expireOn\":\"2024-04-04T06:24:36+0000\"}"
  }

  name = "medvoice-demo-instance-20240405-070911"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    queue_count = 0
    stack_type  = "IPV4_ONLY"
    subnetwork  = "projects/nifty-saga-417905/regions/us-east4/subnetworks/default"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  service_account {
    email  = "184476331500-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  tags = ["http-server", "https-server", "lb-health-check"]
  zone = "us-east4-b"
}
