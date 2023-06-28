
resource "google_gke_hub_membership" "membership" {
  membership_id = "${var.name}-membership"
  endpoint {
    gke_cluster {
      resource_link = "//container.googleapis.com/${google_container_cluster.cluster.id}"
    }
  }
}

resource "google_gke_hub_feature" "feature" {
  name     = "${var.name}-feature"
  location = "global"
}

resource "google_gke_hub_feature_membership" "feature_member" {
  location   = "global"
  feature    = google_gke_hub_feature.feature.name
  membership = google_gke_hub_membership.membership.membership_id
  configmanagement {
    version = "1.6.2"
    config_sync {
      git {
        sync_repo  = "https://github.com/zicongmei/terraform-google"
        policy_dir = "config-sync/resources"
      }
    }
  }
  provider = google-beta
}