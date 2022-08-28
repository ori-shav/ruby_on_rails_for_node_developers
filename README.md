# Environment
- macOS Monterey Version 12.4
- Xcode 13.4.1 - 13.4.1 Command Line Tools

# SETUP AND DOCTRINE
- ruby -v
- rvm list
- rvm install 3.1.2
- rvm --default use 3.1.2
- gem update bundler

# Generate the app
rails new mailing_list --api --database=postgresql --skip-active-storage --skip-action-mailbox

# Docker detour to setup DB
check out README.db.md

# Set up a container running a POSTGRESQL db in docker
docker run --name db -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=changeme -p 5432:5432 -d postgres

# Setup the db
add config to config/database.yml - development & test
```
host: db
username: postgres
password: changeme
```
rails db:setup

# add /etc/hosts entry for the db hostname
Add below to /etc/hosts file
```
127.0.0.1 db
```

# Create member
rails generate model Member email:string subscribed:boolean

- note the files that were created

rails db:migrate

# Add routes for the 'member' model
add below to routes.rb
```
resources :members
```
- observe rails routes
- rails g controller Members

# Add controller logic
- add 'snippets/controller_logic_0' to 'controllers/member_controller.rb'
- test with Postman

# Show debug statements
puts 'debugger statement'
debugger

# Show the rails c
- Rails.application.eager_load!
- ApplicationRecord.subclasses.map(&:name)
- Member.create(email: "asdf", subscribed: true)
- Member.find_by(email: "asdf")

# implement controller logic
- for reference: http://www.railsstatuscodes.com/
- add catch all error handler logic in 'application_controller.rb'

# Add controller logic
- add 'snippets/controller_logic_1' to 'controllers/member_controller.rb'
- test with Postman

# Add model logic for Member
```
class Member < ApplicationRecord
    validates :email, presence: true
    validates :email, uniqueness: true
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    validates_inclusion_of :subscribed, :in => [true, false]
end
```

# Add rate limiting
- github.com/rack/rack-attack
- add "gem 'rack-attack'" to Gemfile
- bundle install

# add the following to 'config/initializers/rack-attack.rb'
Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new 

Rack::Attack.throttle("requests by ip", limit: 5, period: 20) do |request|
    request.ip
end

# Test Rack Attack
...

# Show that this will run in Docker
- add Dockerfile
- add docker-compose.yml
- add entrypoint.sh
- add .env file with the following content
```
PGHOST=db
PGUSER=postgres
PGPASSWORD=changeme
```
- chmod +x entrypoint.sh