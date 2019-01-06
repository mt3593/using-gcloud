## Terraform

The cluster and auxiliary services are managed via terraform. Each has there own directory named accordingly.

Each directory has the following structure
 - *dir-name*
   - modules/
   - main.tf

We use terraforms workspace management to manage the different clusters, what this means is if you want a new cluster you will need to create a new workspace once you are in the directory.

