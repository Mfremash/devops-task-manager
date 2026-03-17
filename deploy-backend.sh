#!/usr/bin/env bash
set -euo pipefail

VERSION="${1:-v0.2.1}"
DOCKERHUB_USER="mfremash"

echo "=== Build backend ==="
docker build -t ${DOCKERHUB_USER}/laravel-backend:${VERSION} ./backend

echo "=== Push backend ==="
docker push ${DOCKERHUB_USER}/laravel-backend:${VERSION}

echo "=== Update backend manifest ==="
sed -i '' "s|image: .*laravel-backend:.*|image: ${DOCKERHUB_USER}/laravel-backend:${VERSION}|g" k8s/backend-deployment.yaml

echo "=== Apply backend manifests ==="
kubectl apply -f k8s/backend-deployment.yaml
kubectl apply -f k8s/backend-service.yaml

echo "=== Restart backend deployment ==="
kubectl rollout restart deployment laravel-backend

echo "=== Current pods ==="
kubectl get pods

echo "=== Done. Backend deployed: ${VERSION} ==="
