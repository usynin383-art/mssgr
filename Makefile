include .env
export
DB_URL=postgres://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@localhost:$(POSTGRES_PORT)/$(POSTGRES_DB)?sslmode=disable
.PHONY: lint, up, down, migrate-up, migrate-down, proto-gen
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
proto-gen:
	mkdir -p gen/go
	protoc -I api/proto \
			--go_out=gen/go --go_opt=paths=source_relative \
    		--go-grpc_out=gen/go --go-grpc_opt=paths=source_relative \
    		api/proto/auth/v1/auth.proto