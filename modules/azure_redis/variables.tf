variable "redis_cache_instances" {
  type = map(object({
    sku      = string
    rgname   = string
    capacity = number
    location = string
    family   = string
  }))
}