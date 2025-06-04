# Makefile

# Variables
BACKEND_DIR=fastapi-backend
FRONTEND_DIR=nextjs-frontend
DOCKER_COMPOSE=docker compose

# Help
.PHONY: help
help:
	@echo "Available commands:"
	@awk '/^[a-zA-Z_-]+:/{split($$1, target, ":"); print "  " target[1] "\t" substr($$0, index($$0,$$2))}' $(MAKEFILE_LIST)

# Setup commands
.PHONY: setup setup-backend setup-frontend

setup: setup-backend setup-frontend ## Setup both backend and frontend

setup-backend: ## Setup backend dependencies and database
	cd $(BACKEND_DIR) && uv sync
	cd $(BACKEND_DIR) && uv run prisma generate
	cd $(BACKEND_DIR) && uv run prisma migrate dev --name init

setup-frontend: ## Setup frontend dependencies
	cd $(FRONTEND_DIR) && yarn install

# Backend commands
.PHONY: start-backend test-backend migrate-db reset-db generate-prisma

start-backend: ## Start the backend server with FastAPI and hot reload
	cd $(BACKEND_DIR) && uv run uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

test-backend: ## Run backend tests using pytest
	cd $(BACKEND_DIR) && uv run pytest

migrate-db: ## Run database migrations
	cd $(BACKEND_DIR) && uv run prisma migrate dev

reset-db: ## Reset database and run migrations
	cd $(BACKEND_DIR) && uv run prisma migrate reset

generate-prisma: ## Generate Prisma client
	cd $(BACKEND_DIR) && uv run prisma generate

# Frontend commands
.PHONY: start-frontend test-frontend build-frontend

start-frontend: ## Start the frontend server with yarn and hot reload
	cd $(FRONTEND_DIR) && yarn dev

test-frontend: ## Run frontend tests
	cd $(FRONTEND_DIR) && yarn test

build-frontend: ## Build frontend for production
	cd $(FRONTEND_DIR) && yarn build

# Docker commands
.PHONY: docker-backend-shell docker-frontend-shell docker-build docker-build-backend \
        docker-build-frontend docker-start-backend docker-start-frontend docker-up \
        docker-down docker-logs docker-test-backend docker-test-frontend

docker-backend-shell: ## Access the backend container shell
	$(DOCKER_COMPOSE) run --rm backend sh

docker-frontend-shell: ## Access the frontend container shell
	$(DOCKER_COMPOSE) run --rm frontend sh

docker-build: ## Build all the services
	$(DOCKER_COMPOSE) build --no-cache

docker-build-backend: ## Build the backend container with no cache
	$(DOCKER_COMPOSE) build backend --no-cache

docker-build-frontend: ## Build the frontend container with no cache
	$(DOCKER_COMPOSE) build frontend --no-cache

docker-start-backend: ## Start the backend container
	$(DOCKER_COMPOSE) up backend

docker-start-frontend: ## Start the frontend container
	$(DOCKER_COMPOSE) up frontend

docker-up: ## Start all services
	$(DOCKER_COMPOSE) up

docker-down: ## Stop all services
	$(DOCKER_COMPOSE) down

docker-logs: ## Show logs for all services
	$(DOCKER_COMPOSE) logs -f

docker-test-backend: ## Run tests for the backend in Docker
	$(DOCKER_COMPOSE) run --rm backend pytest

docker-test-frontend: ## Run tests for the frontend in Docker
	$(DOCKER_COMPOSE) run --rm frontend yarn test

# Database commands
.PHONY: db-up db-down db-reset

db-up: ## Start only the database
	$(DOCKER_COMPOSE) up db -d

db-down: ## Stop the database
	$(DOCKER_COMPOSE) stop db

db-reset: ## Reset database with fresh data
	$(DOCKER_COMPOSE) down db
	$(DOCKER_COMPOSE) up db -d
	sleep 5
	$(MAKE) migrate-db

# Development commands
.PHONY: dev dev-docker clean

dev: ## Start development environment (database + backend + frontend)
	$(DOCKER_COMPOSE) up db -d
	sleep 5
	$(MAKE) start-backend &
	$(MAKE) start-frontend

dev-docker: ## Start development environment using Docker
	$(DOCKER_COMPOSE) up

clean: ## Clean up containers and volumes
	$(DOCKER_COMPOSE) down -v
	docker system prune -f 