# Connection.new takes host and port.

host = 'localhost'
port = 27017

database_name = case Padrino.env
  when :development then 'gamegit_development'
  when :production  then 'gamegit_production'
  when :test        then 'gamegit_test'
end

# Use MONGO_URI if it's set as an environmental variable.
mongo_uri = ENV['MONGO_URI'] || ENV['MONGOHQ_URL']
if mongo_uri
  Mongoid::Config.sessions = {default: {uri: mongo_uri }}
else
  Mongoid::Config.sessions = {default: {hosts: ["#{host}:#{port}"], database: database_name}}
end

# If you want to use a YML file for config, use this instead:
#
#   Mongoid.load!(File.join(Padrino.root, 'config', 'database.yml'), Padrino.env)
#
# And add a config/database.yml file like this:
#   development:
#     sessions:
#       default:
#         database: logger_development
#         hosts:
#           - localhost:27017
#   production:
#     sessions:
#       default:
#         database: logger_production
#         hosts:
#           - localhost:27017
#   test:
#     sessions:
#       default:
#         database: logger_test
#         hosts:
#           - localhost:27017
#
#
# More installation and setup notes are on http://mongoid.org/en/mongoid/docs/installation.html#configuration
