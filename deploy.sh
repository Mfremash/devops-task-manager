#!/usr/bin/env bash
set -euo pipefail

VERSION="${1:-v0.2.1}"
DOCKERHUB_USER="mfremash"

echo "=== Build backend ==="
docker build -t ${DOCKERHUB_USER}/laravel-backend:${VERSION} ./backend

echo "=== Build frontend ==="
docker build -t ${DOCKERHUB_USER}/react-frontend:${VERSION} ./frontend

echo "=== Push backend ==="
docker push ${DOCKERHUB_USER}/laravel-backend:${VERSION}

echo "=== Push frontend ==="
docker push ${DOCKERHUB_USER}/react-frontend:${VERSION}

echo "=== Update Kubernetes manifests ==="
sed -i '' "s|image: .*laravel-backend:.*|image: ${DOCKERHUB_USER}/laravel-backend:${VERSION}|g" k8s/backend-deployment.yaml
sed -i '' "s|image: .*react-frontend:.*|image: ${DOCKERHUB_USER}/react-frontend:${VERSION}|g" k8s/frontend-deployment.yaml

echo "=== Apply manifests ==="
kubectl apply -f k8s/

echo "=== Restart deployments ==="
kubectl rollout restart deployment laravel-backend
kubectl rollout restart deployment react-frontend

echo "=== Current pods ==="
kubectl get pods

echo "=== Done. Version deployed: ${VERSION} ==="

