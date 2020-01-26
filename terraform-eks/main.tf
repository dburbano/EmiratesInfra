
data "aws_eks_cluster" "cluster" {
  name = module.my-cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.my-cluster.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.9"
}

provider "aws" {
  region    = "us-east-1"
}

module "my-cluster" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "eks-dev"
  cluster_version = "1.14"
  subnets         = ["subnet-0c27636ae347e01e7", "subnet-032f530b700ba3a7d", "subnet-040a5a687412aa3f8"]
  vpc_id          = "vpc-014be38c2058c2123"

  worker_groups = [
    {
      instance_type = "m4.large"
      asg_max_size  = 5
    }
  ]
}


#--vpc-private-subnets=subnet-01c63fef57ac446cb,subnet-032f530b700ba3a7d,subnet-040a5a687412aa3f8
#--vpc-public-subnets=subnet-0c27636ae347e01e7,subnet-06b339df32d7ab13c,subnet-03b7c56e09d98a25d


