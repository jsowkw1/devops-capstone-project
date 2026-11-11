.PHONY: all help install venv lint test run db

help: ## Display this help
	@awk 'BEGIN {FS = ":.*##"} /^[a-zA-Z_-]+:.*##/ { printf "  %-10s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

install: ## Install dependencies
	python -m pip install --upgrade pip wheel
	pip install -r requirements.txt

lint: ## Run the linter
	flake8 service tests --count --select=E9,F63,F7,F82 --show-source --statistics
	flake8 service tests --count --max-complexity=10 --max-line-length=127 --statistics
	pylint service tests --max-line-length=127

test: ## Run the unit tests
	nosetests --with-spec --spec-color --with-coverage --cover-package=service

run: ## Run the service
	honcho start

db: ## Start a local PostgreSQL in Docker
	docker run -d --name postgresql -p 5432:5432 -e POSTGRES_PASSWORD=postgres postgres:alpine
