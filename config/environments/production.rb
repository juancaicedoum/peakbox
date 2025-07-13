# config/environments/production.rb

require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.enable_reloading = false
  config.secret_key_base = ENV["SECRET_KEY_BASE"]
  # Eager load code on boot. This eager loads most of Rails and
  # your application in order to prepare for production.
  config.eager_load = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching in development.
  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end


  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for Apache and NGINX
  # config.action_dispatch.x_sendfile_header = "X-Accel-Redirect" # for NGINX

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Mount Action Cable outside main process or loop that processes HTTP requests.
  # config.action_cable.mount_path = nil
  # config.action_cable.url = ENV["ACTION_CABLE_URL"]
  # config.action_cable.allowed_request_origins = [ "http://example.com", /http:\/\/example.*/ ]

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # Use the lowest log level to ensure that all message types are logged.
  # For more comprehensive logging, you may want to set this to :debug.
  config.log_level = :info

  # Prepend all log lines with the following tags.
  config.log_tags = [ :request_id ]

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Use a real queuing backend for Active Job (and separate queues per environment).
  # config.active_job.queue_adapter = :resque
  # config.active_job.queue_adapter = :sidekiq

  config.action_mailer.perform_caching = false

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure your mailer to use a delivery method that does not raise.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for original locale fall back to
  # the development locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Don't log any deprecations.
  config.active_support.deprecation = :silence

  # Log disallowed deprecations to Rails.logger by default.
  # config.active_support.disallowed_deprecation_warnings = []

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  # Enable query cache by default.
#  config.active_record.query_cache_enabled = true

  # Inserts middleware to perform automatic browser detection on assets requests.
  # config.assets.js_compressor = :uglifier

  # Compress CSS using a CSS compressor or Sass.
  # config.assets.css_compressor = :sass

  # Use the local file system for storing cache.
  # config.cache_store = :file_store, "tmp/cache/production"

  # Enable serving of images, stylesheets, and JavaScript from an asset server.
  # config.action_controller.asset_host = "http://assets.example.com"

  # Enable JavaScript compilation with Webpacker if you're using it.
  # config.webpacker.check_yarn_integrity = false

  # You need to explicitly enable `config.action_view.button_to_uses_form_method_display` if you use it.
  # This option will be removed in Rails 8.0.
  # config.action_view.button_to_uses_form_method_display = true

  # Uncomment if you're not using strict_loading mode in your production app.
  # config.active_record.strict_loading_by_default = true
end
