# First time setup

You will first need a google account setup, to do this head over to [google cloud](http://cloud.google.com) and setup a trial membership.

## Contents

- [Requirements](#requirements)
- [Setup local work station](#setup-local-work-station)
- [Setting up cluster](#setting-up-cluster)
- [destroy_cluster](#destroy-cluster)

## Requirements

 - [terraform](https://www.terraform.io/) v0.11.7
   - [terraform helm module](https://github.com/terraform-providers/terraform-provider-helm) v0.6.0
 - [helm](https://helm.sh/) v2.9.1
 - [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) v1.9.2
 - [gcloud](https://cloud.google.com/sdk/install) 228.0.0
 
I have given the versions I am using locally as of writing, newer versions may still work. Please let me know if it works with later version or if I miss any dependencies, I will update docs.

## Setup local work station

You will need to make sure your `gcloud` config is setup to do this execute the following:
```bash
gcloud init ## follow the steps given
gcloud config set compute/zone europe-west1-c ## Or wherever you want to set the compute/zone to
```

## Setting up cluster

We will be using terraform to manage our cluster. Have a quick look at [terraform directory](../terraform) to get a general idea of how the folder structure is layed out.

The state will be uploaded to a Google storage bucket, this bucket will need to be created and will need to have a unique name. You will have to create the bucket and edit the [main.tf](main.tf) file: 
```bash
gsutil mb -c nearline -l europe-west1 gs://mtinsley-terraform-state # change to your bucket name
```

You'll also need to update the project given in the main.tf with the project-id given in:
```bash
gcloud projects list
```

Once the above values have been updated you can continue.

You should then be able to initialise terraform:
```bash
terraform init
```

As mentied above its perferable to work within terraforms workspaces, so lets create a new workspace:
```bash
terraform workspace new dev
```

Now we can start creating our cluster, run:
```bash
terraform apply #type yes when prompted
```

This takes a while to complete but one it is you will have a k8s cluster setup!
Once this is done you will need to create the credentials for the kubectl command via:
```bash
gcloud container clusters get-credentials dev # cluster has same name as terraform workspace
```

Might take awhile for the cluster to be fully ready.

## Destroy cluster

In the cluster directory run the following:

```bash
terraform destroy
terraform workspace select default
terraform workspace delete dev # Name of cluster to delete
```
