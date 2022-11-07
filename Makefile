compose:
	docker compose up -d --build --remove-orphans

sh:
	docker compose exec app /bin/sh

root:
	docker compose exec -u root app /bin/sh
