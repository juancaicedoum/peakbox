# config/environments/development.rb

require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded any time
  # it changes. This enables you to make changes without having to restart the server.
  config.enable_reloading = true

  # Eager load code on boot to detect eager loading issues.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable server timing.
  config.server_timing = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
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

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions for unpermitted parameters.
  config.action_controller.forbid_unknown_action_parameters = true

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Uncomment if you're not using strict_loading mode in your development app.
  # config.active_record.strict_loading_by_default = true

  # Enable asynchronous logging only in environments where you might need it.
  # config.log_file_size_threshold = 0
  # config.log_level = :info # For most applications, :info is a good default.
  # config.autoflush_log = true

  # Uncomment if you want to use the Rails 7.1 default for `config.action_view.button_to_uses_form_method_display`.
  # This option will be removed in Rails 8.0.
  # config.action_view.button_to_uses_form_method_display = true

  # Devise configuration for default URL options
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  # Desactiva la verificación estricta de callbacks que causa el error "Unknown action".
  # Esto es un workaround para el desarrollo en tu entorno actual.
  config.action_controller.raise_on_missing_callback_actions = false 

end
