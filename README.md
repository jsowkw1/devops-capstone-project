# DevOps Capstone Project — Customer Accounts Microservice

[![Build Status](https://github.com/jsowkw1/devops-capstone-project/actions/workflows/ci-build.yaml/badge.svg)](https://github.com/jsowkw1/devops-capstone-project/actions)

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Python 3.9](https://img.shields.io/badge/Python-3.9-green.svg)](https://shields.io/)

**Project name:** DevOps Capstone Project — Customer Accounts RESTful microservice

This repository contains the IBM DevOps and Software Engineering Capstone project: a Flask
RESTful microservice that manages customer accounts for an eCommerce application. It was
developed with Agile planning (GitHub Kanban board), Test Driven Development (nose + coverage),
Continuous Integration (GitHub Actions), security hardening (Flask-Talisman + Flask-CORS),
containerization (Docker), deployment to Kubernetes / OpenShift and Continuous Delivery (Tekton).

## REST API

| Method | URL                  | Description                 |
|--------|----------------------|-----------------------------|
| GET    | `/health`            | Health check                |
| GET    | `/`                  | Service information         |
| POST   | `/accounts`          | Create an account           |
| GET    | `/accounts`          | List all accounts           |
| GET    | `/accounts/{id}`     | Read an account             |
| PUT    | `/accounts/{id}`     | Update an account           |
| DELETE | `/accounts/{id}`     | Delete an account           |

## Account model

| Field        | Type       | Notes                  |
|--------------|------------|------------------------|
| id           | Integer    | Primary key            |
| name         | String(64) |                        |
| email        | String(64) |                        |
| address      | String(256)|                        |
| phone_number | String(32) | optional               |
| date_joined  | Date       | defaults to today      |

## Local development

```bash
make install        # pip install -r requirements.txt
make db             # start PostgreSQL in Docker
make lint           # flake8
make test           # nosetests with coverage
make run            # honcho start (http://localhost:8000)
```

## Container and Kubernetes

```bash
docker build -t accounts:1 .
kubectl apply -f deploy/
```

The CD pipeline is defined in `tekton/` (clone → lint → test → build → deploy).

## Repository layout

```text
service/                - Flask service package
├── __init__.py         - app factory, Talisman and CORS setup
├── config.py           - configuration
├── models.py           - Account model
├── routes.py           - REST API routes
└── common/             - status codes, error handlers, logging, CLI
tests/                  - unit tests (models + routes) and factories
deploy/                 - Kubernetes manifests (postgres, deployment, service)
tekton/                 - Tekton tasks and pipeline
.github/workflows/      - CI pipeline (ci-build.yaml)
.github/ISSUE_TEMPLATE/ - user story template
```

## License

Copyright (c) 2016, 2023 IBM Corp. All rights reserved.
Licensed under the Apache License. See [LICENSE](LICENSE)

This repository is part of the IBM DevOps and Software Engineering Professional Certificate.
