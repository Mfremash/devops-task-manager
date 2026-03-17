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
  dockerfile = "Dockerfile"
  tags = [
    "${DOCKERHUB_USER}/laravel-backend:${TAG}"
  ]
}

target "frontend" {
  context    = "./frontend"
  dockerfile = "Dockerfile"
  tags = [
    "${DOCKERHUB_USER}/react-frontend:${TAG}"
  ]
}
