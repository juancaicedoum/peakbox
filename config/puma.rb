# config/puma.rb

# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting controls the number of request threads to use.
# Default is 5 threads for development environment.
threads_count = ENV.fetch("RAILS_MAX_THREADS", 3)
threads threads_count, threads_count

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
port ENV.fetch("PORT", 3000)

# Specifies the `environment` that Puma will run in.
#
environment ENV.fetch("RAILS_ENV", "development")

# Specifies the `pidfile` that Puma will use.
# pidfile ENV.fetch("PIDFILE", "tmp/pids/server.pid")

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked processes that will share the same Puma application.
# Each worker has its own thread pool and process ID.
# workers ENV.fetch("WEB_CONCURRENCY", 2)

# Use the `preload_app!` method to load your application in the master process before workers are forked.
# This allows for faster worker boot times and basic copy-on-write memory savings.
# preload_app!

# Allow puma to be restarted by `bin/rails restart` command.
plugin :tmp_restart

# Use Solid Queue in Puma if desired, by setting SOLID_QUEUE_IN_PUMA=1
plugin :solid_queue if ENV["SOLID_QUEUE_IN_PUMA"]
