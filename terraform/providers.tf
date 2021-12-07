terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.44.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "2.1.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "local" {

}

provider "http" {

}

provider "tls" {

}

provider "null" {

}