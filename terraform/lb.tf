resource "random_id" "default" {
  byte_length = 16
}

resource "google_compute_backend_bucket_signed_url_key" "default" {
  name           = "${local.project}-${local.prefix}"
  key_value      = random_id.default.b64_url
  backend_bucket = google_compute_backend_bucket.backend_bucket.name
}

resource "google_compute_backend_bucket" "backend_bucket" {
  name        = "${local.project}-${local.prefix}"
  bucket_name = google_storage_bucket.default-a.name
  enable_cdn  = true

  depends_on = [
    google_storage_bucket.default-a
  ]
}

resource "google_compute_url_map" "default" {
  name = "${local.project}-${local.prefix}"

  default_service = google_compute_backend_bucket.backend_bucket.id

  host_rule {
    hosts        = ["*"]
    path_matcher = "path-matcher-2"
  }
  path_matcher {
    name            = "path-matcher-2"
    default_service = google_compute_backend_bucket.backend_bucket.id

    path_rule {
      paths   = ["/test/*"]
      service = google_compute_backend_bucket.backend_bucket.id
    }
  }
}

resource "google_compute_target_http_proxy" "default" {
  name    = "${local.project}-${local.prefix}"
  url_map = google_compute_url_map.default.id
}

resource "google_compute_global_forwarding_rule" "default" {
  name = "${local.project}-${local.prefix}"

  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = "80"
  target                = google_compute_target_http_proxy.default.id
  ip_address            = google_compute_global_address.default.id
}

resource "google_compute_global_address" "default" {
  name = "${local.project}-${local.prefix}"
}
