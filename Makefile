console:
	bundle exec rails console

c: console

db-reset:
	bundle exec rails db:reset db:fixtures:load

dev:
	bin/webpack-dev-server

fixtures:
	bundle exec rails db:fixtures:load

server:
	bundle exec rails server

s: server
