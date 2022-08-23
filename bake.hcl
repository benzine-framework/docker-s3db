group "default" {
  targets = [
    "postgres-14",
    "postgres-13",
    "postgres-12",
    "postgres-11",
    "postgres-10"
  ]
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

target "postgres-12" {
  context = "."
  dockerfile = "Dockerfile"
  platforms = ["arm64","amd64"]
  tags = ["benzine/postgres:12"]
  args = {
    PGSQL_VERSION = 12
  }
}

target "postgres-11" {
  context = "."
  dockerfile = "Dockerfile"
  platforms = ["arm64","amd64"]
  tags = ["benzine/postgres:11"]
  args = {
    PGSQL_VERSION = 11
  }
}

target "postgres-10" {
  context = "."
  dockerfile = "Dockerfile"
  platforms = ["arm64","amd64"]
  tags = ["benzine/postgres:10"]
  args = {
    PGSQL_VERSION = 10
  }
}
