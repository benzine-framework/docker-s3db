# docker-bake.dev.hcl
group "default" {
  targets = ["postgres-14", "postgres-13"]
}

target "postgres-14" {
  context = "."
  dockerfile = "Dockerfile"
  platforms = ["arm64","amd64"]
  tags = ["benzine/postgres:14", "benzine/postgres:latest"]
  args = {
    PGSQL_VERSION = 14
  }
}

target "postgres-13" {
  context = "."
  dockerfile = "Dockerfile"
  platforms = ["arm64","amd64"]
  tags = ["benzine/postgres:13"]
  args = {
    PGSQL_VERSION = 13
  }
}
