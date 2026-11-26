include .env
export
DB_URL=postgres://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@localhost:$(POSTGRES_PORT)/$(POSTGRES_DB)?sslmode=disable
.PHONY: lint, up, down, migrate-up, migrate-down
lint:
	golangci-lint run
up:
	docker compose up -d && docker compose ps
down:
	docker compose down
migrate-up:
	goose -dir migrations postgres "$(DB_URL)" up

migrate-down:
	goose -dir migrations postgres "$(DB_URL)" down