resource "google_storage_bucket" "default-a" {
  name          = "${local.project}-${local.prefix}"
  location      = "ASIA-NORTHEAST1"
  force_destroy = true

  storage_class            = "STANDARD"
  public_access_prevention = "enforced"
}

resource "google_storage_bucket_iam_member" "public_rule" {
  bucket = google_storage_bucket.default-a.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:service-${data.google_project.project.number}@cloud-cdn-fill.iam.gserviceaccount.com"

  depends_on = [
    google_compute_backend_bucket_signed_url_key.default
  ]
}

