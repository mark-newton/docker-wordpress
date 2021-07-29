build:
	mkdir -p vol-db vol-wp wp-plugins wp-themes
	docker-compose build

start:
	docker-compose up -d

install: build start

check:
	docker-compose logs
	docker-compose ps

down:
	docker-compose down

clean: down
	@echo "💥 Removing related folders/files..."
	@rm -rf  vol-db vol-wp wp-plugins wp-themes

reset: clean
