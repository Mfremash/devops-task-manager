variable "DOCKERHUB_USER" {
  default = "mfremash"
}

variable "TAG" {
  default = "latest"
}

group "default" {
  targets = ["backend", "frontend"]
}

target "backend" {
  context    = "./backend"
  dockerfile = "./backend/Dockerfile"
  tags = [
    "${DOCKERHUB_USER}/laravel-backend:${TAG}"
  ]
}

target "frontend" {
  context    = "./frontend"
  dockerfile = "./frontend/Dockerfile"
  tags = [
    "${DOCKERHUB_USER}/react-frontend:${TAG}"
  ]
}
