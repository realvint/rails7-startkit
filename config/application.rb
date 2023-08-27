# frozen_string_literal: true

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.

    # Running this initializer early
    # To make settings be abailable on WebServer start
    # To make configs available in `config/environments/%{environment}.rb`
    require_relative "initializers/_CONFIG"

    config.load_defaults 7.0

    config.active_job.queue_adapter = :sidekiq

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Removes `field_with_errors` wrapper class for Rails forms
    config.action_view.field_error_proc = proc do |html_tag, instance|
      # binding.pry
      content_tag :div, html_tag, class: :field_with_errors
    end
  end
end
