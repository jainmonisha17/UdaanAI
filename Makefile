.PHONY: help up down restart logs build test dev-install

PYTHON ?= python3

help:
	@echo "Udaan AI - Makefile Commands"
	@echo "----------------------------"
	@echo "  make up          : Build service images and start all services"
	@echo "  make down        : Stop all services using Docker Compose"
	@echo "  make restart     : Restart all Docker Compose services"
	@echo "  make logs        : View logs for all services"
	@echo "  make build       : Build all Docker containers"
	@echo "  make test        : Run pytest health tests across all services"

up:
	docker compose up -d --build

down:
	docker compose down

restart:
	docker compose restart

logs:
	docker compose logs -f

build:
	docker compose build

test:
	@echo "Running backend health tests..."
	$(PYTHON) -m pytest backend/api-gateway
	$(PYTHON) -m pytest backend/auth-service
	$(PYTHON) -m pytest backend/student-service
	$(PYTHON) -m pytest backend/assessment-service
	cd backend/ai-career-service && $(PYTHON) -m pytest
	$(PYTHON) -m pytest backend/roadmap-service
	$(PYTHON) -m pytest backend/institution-service
	$(PYTHON) -m pytest backend/admin-analytics-service
