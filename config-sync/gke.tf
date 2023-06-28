resource "google_container_cluster" "cluster" {
  name               = "${var.name}-cluster"
  location           = var.region
  initial_node_count = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
}
