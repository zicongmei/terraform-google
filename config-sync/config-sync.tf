
resource "google_gke_hub_membership" "membership" {
  membership_id = "${var.name}-membership"
  endpoint {
    gke_cluster {
      resource_link = "//container.googleapis.com/${google_container_cluster.cluster.id}"
    }
  }
}

resource "google_gke_hub_feature" "feature" {
  name     = "configmanagement"
  location = "global"
}

resource "google_gke_hub_feature_membership" "feature_member" {
  location   = "global"
  feature    = google_gke_hub_feature.feature.name
  membership = google_gke_hub_membership.membership.membership_id
  configmanagement {
    version = "1.15.1"
    config_sync {
      source_format = "unstructured"
      git {
        sync_repo   = "https://github.com/zicongmei/terraform-google"
        policy_dir  = "config-sync/resources"
        secret_type = "none"
        sync_branch = "main"
      }
    }
  }
  provider = google-beta
}