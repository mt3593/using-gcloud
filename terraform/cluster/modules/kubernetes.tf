resource "google_compute_network" "cluster_network" {
  name = "${var.cluster_name}-network"
  description = "Network for GKE cluster: ${var.cluster_name}"
  auto_create_subnetworks = "true"
}

resource "google_compute_firewall" "ssh" {
  name          = "${var.cluster_name}-ssh"
  description = "Allow SSH"
  network       = "${google_compute_network.cluster_network.self_link}"
  source_ranges = "${var.k8s_node_firewall}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

}

resource "google_container_cluster" "kubernetes" {
  name = "${var.cluster_name}"
  description = "GKE cluster: ${var.cluster_name}"

  min_master_version = "1.11.5-gke.5"
  node_version = "1.11.5-gke.5"

  zone = "europe-west1-c"
  additional_zones = ["europe-west1-b", "europe-west1-d"]

  network = "${google_compute_network.cluster_network.self_link}"

  maintenance_policy {
    daily_maintenance_window {
      start_time = "07:00"
    }
  }

  node_pool {
    node_config {
      machine_type = "n1-standard-1" # This is to keep costs down but ideally you'll want bigger boxes.
      oauth_scopes = ["compute-rw", "storage-ro", "logging-write", "monitoring"]
    }

    autoscaling { # These are per region, so given we have 3 regions this will be 3 * 1 = 3 nodes
      max_node_count = 1 # Again to keep costs down, ideally you'll want to up this.
      min_node_count = 1
    }

    initial_node_count = 1

    management {
      auto_repair = true
    }
  }

}
