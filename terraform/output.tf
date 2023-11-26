output "global_ip" {
  value = google_compute_global_address.default.address
}

output "presigned_key" {
  value = random_id.default
}

data "google_project" "project" {
}

