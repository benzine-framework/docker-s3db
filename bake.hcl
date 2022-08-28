group "default" {
  targets = [
    "postgres-14",
    "postgres-13",
    "postgres-12",
    "postgres-11",
    "postgres-10",
    "mariadb-10-9",
    "mariadb-10-8",
    "mariadb-10-7",
    "mariadb-10-6",
    "mariadb-10-5",
    "mariadb-10-4",
    "mariadb-10-3",
  ]
}

target "postgres-14" {
  context = "."
  dockerfile = "Dockerfile.postgres"
  platforms = ["arm64","amd64"]
  tags = [
    "benzine/postgres:14", "benzine/postgres:latest",
    "ghcr.io/benzine-framework/s3db:postgres-14", "ghcr.io/benzine-framework/s3db:postgres"
  ]
  args = {
    PGSQL_VERSION = 14
  }
}

target "postgres-13" {
  context = "."
  dockerfile = "Dockerfile.postgres"
  platforms = ["arm64","amd64"]
  tags = ["benzine/postgres:13", "ghcr.io/benzine-framework/s3db:postgres-13"]
  args = {
    PGSQL_VERSION = 13
  }
}

target "postgres-12" {
  context = "."
  dockerfile = "Dockerfile.postgres"
  platforms = ["arm64","amd64"]
  tags = ["benzine/postgres:12", "ghcr.io/benzine-framework/s3db:postgres-12"]
  args = {
    PGSQL_VERSION = 12
  }
}

target "postgres-11" {
  context = "."
  dockerfile = "Dockerfile.postgres"
  platforms = ["arm64","amd64"]
  tags = ["benzine/postgres:11", "ghcr.io/benzine-framework/s3db:postgres-11"]
  args = {
    PGSQL_VERSION = 11
  }
}

target "postgres-10" {
  context = "."
  dockerfile = "Dockerfile.postgres"
  platforms = ["arm64","amd64"]
  tags = ["benzine/postgres:10", "ghcr.io/benzine-framework/s3db:postgres-10"]
  args = {
    PGSQL_VERSION = 10
  }
}

target "mariadb-10-9" {
  context = "."
  dockerfile = "Dockerfile.mariadb"
  platforms = ["arm64", "amd64"]
  tags = [
    "benzine/mariadb:10.9", "benzine/mariadb:latest",
    "ghcr.io/benzine-framework/s3db:mariadb-10.9", "ghcr.io/benzine-framework/s3db:mariadb",
  ]
  args = {
    MARIADB_VERSION=10.9
  }
}
target "mariadb-10-8" {
  context = "."
  dockerfile = "Dockerfile.mariadb"
  platforms = ["arm64", "amd64"]
  tags = ["benzine/mariadb:10.8", "ghcr.io/benzine-framework/s3db:mariadb-10.8"]
  args = {
    MARIADB_VERSION=10.8
  }
}
target "mariadb-10-7" {
  context = "."
  dockerfile = "Dockerfile.mariadb"
  platforms = ["arm64", "amd64"]
  tags = ["benzine/mariadb:10.7", "ghcr.io/benzine-framework/s3db:mariadb-10.7"]
  args = {
    MARIADB_VERSION=10.7
  }
}
target "mariadb-10-6" {
  context = "."
  dockerfile = "Dockerfile.mariadb"
  platforms = ["arm64", "amd64"]
  tags = ["benzine/mariadb:10.6", "ghcr.io/benzine-framework/s3db:mariadb-10.6"]
  args = {
    MARIADB_VERSION=10.6
  }
}
target "mariadb-10-5" {
  context = "."
  dockerfile = "Dockerfile.mariadb"
  platforms = ["arm64", "amd64"]
  tags = ["benzine/mariadb:10.5", "ghcr.io/benzine-framework/s3db:mariadb-10.5"]
  args = {
    MARIADB_VERSION=10.5
  }
}
target "mariadb-10-4" {
  context = "."
  dockerfile = "Dockerfile.mariadb"
  platforms = ["arm64", "amd64"]
  tags = ["benzine/mariadb:10.4", "ghcr.io/benzine-framework/s3db:mariadb-10.4"]
  args = {
    MARIADB_VERSION=10.4
  }
}
target "mariadb-10-3" {
  context = "."
  dockerfile = "Dockerfile.mariadb"
  platforms = ["arm64", "amd64"]
  tags = ["benzine/mariadb:10.3", "ghcr.io/benzine-framework/s3db:mariadb-10.3"]
  args = {
    MARIADB_VERSION=10.3
  }
}