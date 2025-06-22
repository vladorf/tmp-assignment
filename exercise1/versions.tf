terraform {
  backend "s3" {
    bucket       = "vuzik-home-assignment-tfstate-0d8287bd19f2e9a5697520346636da64"
    key          = "terraform.tfstate"
    region       = "eu-west-1"
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
