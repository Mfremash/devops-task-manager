# DevOps Task Manager

Учебный fullstack проект, развернутый в Kubernetes.

## Стек проекта

- **Frontend:** React
- **Backend:** Laravel
- **Database:** PostgreSQL
- **Containerization:** Docker
- **Orchestration:** Kubernetes
- **CI/CD:** GitHub Actions + Docker Hub

---

## Архитектура

Проект состоит из трех основных компонентов:

- **react-frontend** — пользовательский интерфейс
- **laravel-backend** — API и бизнес-логика
- **postgres** — база данных PostgreSQL

В Kubernetes используются:

- **Deployment** для frontend, backend и postgres
- **Service** для связи между компонентами
- **Ingress** для доступа к приложению
- **PersistentVolumeClaim** для сохранения данных PostgreSQL

---

## Kubernetes манифесты

Манифесты находятся в папке `k8s/`.

Основные файлы:

- `frontend-deployment.yaml`
- `frontend-service.yaml`
- `backend-deployment.yaml`
- `backend-service.yaml`
- `postgres-deployment.yaml`
- `postgres-service.yaml`
- `postgres-secret.yaml`
- `postgres-pvc.yaml`
- `ingress.yaml`

---

## CI/CD

В проекте настроены отдельные GitHub Actions workflow:

- **Build and Push Backend Image**
- **Build and Push Frontend Image**

При изменении соответствующей части проекта собирается Docker image и отправляется в Docker Hub.

---

## Docker образы

Используются образы:

- `mfremash/laravel-backend`
- `mfremash/react-frontend`

---

## Как запустить проект в Kubernetes

### 1. Применить манифесты

```bash
kubectl apply -f k8s/
