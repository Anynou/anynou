resource "google_compute_network" "kubernetes" {
  name = "kubernetes"
  routing_mode = "REGIONAL"
  auto_create_subnetworks = "false"

}

resource "google_compute_subnetwork" "kube" {
  name = "sub-kube"
  region = "us-central1"
  ip_cidr_range = "10.128.0.0/24"
  network       = google_compute_network.kubernetes.self_link
}

resource "google_compute_firewall" "externo" {
  name    = "externo-firewall"
  network = "${google_compute_network.kubernetes.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  source_ranges = ["0.0.0.0/0"]

}