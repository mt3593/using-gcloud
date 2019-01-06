variable "cluster_name" {
  type = "string"
  description = "The name of the cluster"
}

variable "k8s_node_firewall" {
  type = "list"
  default = ["0.0.0.0/0"] # This is opening up to the whole world so not a good idea in general, will need to specify your IP address ranges.
  description = "Kubernetes node firewall rules"
}
