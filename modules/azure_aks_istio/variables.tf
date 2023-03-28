variable "cluster_name" {
  description = "The name of the AKS cluster"
}

variable "istio_chart_version" {
  description = "The version of the Istio Helm chart to install"
  default     = "1.11.0"
}