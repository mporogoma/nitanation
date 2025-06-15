# exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
rails db:drop 
rails db:create 
bundle exec rails db:migrate
# rails db:seed