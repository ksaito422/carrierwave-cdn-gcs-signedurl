CarrierWave.configure do |config|
  if %w(staging production).include?(Rails.env)
    config.fog_provider = 'fog/google'
    config.fog_credentials = {
      provider: 'Google',
      google_project: Rails.application.credentials.google_project,
      google_json_key_string: Rails.application.credentials.google_json_key_string,
      # google_json_key_location: '',
    }
    config.fog_directory = Rails.application.credentials.gcs_bucket
    config.fog_public = nil
    config.storage = :fog
    config.cache_storage = :fog
  else
    config.storage = :file
  end
end
