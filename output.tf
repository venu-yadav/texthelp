output "ecs_cluster_id" {
  value = module.ecs.cluster_id
}

output "redis_endpoint" {
  value = module.redis.endpoint
}

output "rds_endpoint" {
  value = module.rds.endpoint
}
