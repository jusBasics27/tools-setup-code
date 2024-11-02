module "tools" {

  for_each = var.tools
  source = "./modules-ec2"
  tool_name= each.key
  sg_port=each.value["port"]
  volume_size=each.value["volume_size"]
  instance_type = each.value["instance_type"]
  domain_name = var.domain_name
  zone_id=var.zone_id
}