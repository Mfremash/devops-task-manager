#!/usr/bin/env bash
set -euo pipefail

VERSION="${1:-v0.2.1}"
DOCKERHUB_USER="mfremash"

echo "=== Build frontend ==="
docker build -t ${DOCKERHUB_USER}/react-frontend:${VERSION} ./frontend

echo "=== Push frontend ==="
docker push ${DOCKERHUB_USER}/react-frontend:${VERSION}

echo "=== Update frontend manifest ==="
sed -i '' "s|image: .*react-frontend:.*|image: ${DOCKERHUB_USER}/react-frontend:${VERSION}|g" k8s/frontend-deployment.yaml

echo "=== Apply frontend manifests ==="
kubectl apply -f k8s/frontend-deployment.yaml
kubectl apply -f k8s/frontend-service.yaml
kubectl apply -f k8s/ingress.yaml

echo "=== Restart frontend deployment ==="
kubectl rollout restart deployment react-frontend

echo "=== Current pods ==="
kubectl get pods

echo "=== Done. Frontend deployed: ${VERSION} ==="
