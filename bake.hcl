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
  dockerfile = "Dockerfile.postgres"
  platforms = ["arm64","amd64"]
  tags = ["benzine/postgres:14", "benzine/postgres:latest"]
  args = {
    PGSQL_VERSION = 14
  }
}

target "postgres-13" {
  context = "."
  dockerfile = "Dockerfile.postgres"
  platforms = ["arm64","amd64"]
  tags = ["benzine/postgres:13"]
  args = {
    PGSQL_VERSION = 13
  }
}

target "postgres-12" {
  context = "."
  dockerfile = "Dockerfile.postgres"
  platforms = ["arm64","amd64"]
  tags = ["benzine/postgres:12"]
  args = {
    PGSQL_VERSION = 12
  }
}

target "postgres-11" {
  context = "."
  dockerfile = "Dockerfile.postgres"
  platforms = ["arm64","amd64"]
  tags = ["benzine/postgres:11"]
  args = {
    PGSQL_VERSION = 11
  }
}

target "postgres-10" {
  context = "."
  dockerfile = "Dockerfile.postgres"
  platforms = ["arm64","amd64"]
  tags = ["benzine/postgres:10"]
  args = {
    PGSQL_VERSION = 10
  }
}

target "mariadb-10.9" {
  context = "."
  dockerfile = "Dockerfile.mariadb"
  platforms = ["arm64", "amd64"]
  tags = ["benzine/mariadb:10.9", "benzine/mariadb:latest"]
  args = {
    MARIADB_VERSION=10.9
  }
}
target "mariadb-10.8" {
  context = "."
  dockerfile = "Dockerfile.mariadb"
  platforms = ["arm64", "amd64"]
  tags = ["benzine/mariadb:10.8"]
  args = {
    MARIADB_VERSION=10.8
  }
}
target "mariadb-10.7" {
  context = "."
  dockerfile = "Dockerfile.mariadb"
  platforms = ["arm64", "amd64"]
  tags = ["benzine/mariadb:10.7"]
  args = {
    MARIADB_VERSION=10.7
  }
}
target "mariadb-10.6" {
  context = "."
  dockerfile = "Dockerfile.mariadb"
  platforms = ["arm64", "amd64"]
  tags = ["benzine/mariadb:10.6"]
  args = {
    MARIADB_VERSION=10.6
  }
}
target "mariadb-10.5" {
  context = "."
  dockerfile = "Dockerfile.mariadb"
  platforms = ["arm64", "amd64"]
  tags = ["benzine/mariadb:10.5"]
  args = {
    MARIADB_VERSION=10.5
  }
}
target "mariadb-10.4" {
  context = "."
  dockerfile = "Dockerfile.mariadb"
  platforms = ["arm64", "amd64"]
  tags = ["benzine/mariadb:10.4"]
  args = {
    MARIADB_VERSION=10.4
  }
}
target "mariadb-10.3" {
  context = "."
  dockerfile = "Dockerfile.mariadb"
  platforms = ["arm64", "amd64"]
  tags = ["benzine/mariadb:10.3"]
  args = {
    MARIADB_VERSION=10.3
  }
}