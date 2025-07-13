# build.sh
#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -eo pipefail

# Ensure Node.js and Yarn are installed if needed by your project
# Render's default Ruby environment might not have them by default,
# or not configured for asset precompilation.

# Check if yarn exists, if not, install it via npm
# This might be redundant on newer Render envs, but ensures it
if ! command -v yarn &> /dev/null
then
    echo "yarn not found, installing via npm..."
    npm install -g yarn
fi

# Check if Node.js is configured via asdf (if you use it locally)
# If using asdf, ensure .tool-versions exists with nodejs version

# Run original build command
bundle install
rails assets:precompile RAILS_ENV=production
rails db:migrate
