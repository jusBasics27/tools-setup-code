variable "tools" {

  default={
    vault ={
      port=8200
      volume_size=20
      instance_type="t3.small"
      policy_list = []
    }

    github-runner ={
      port=80 # dummy port
      volume_size=50
      instance_type="t3.small"
      policy_list = ["*"]
    }
  }
}

variable "zone_id" {
  default="Z0252555OF8RI2R4KATG"
}

variable "domain_name" {
  default="waferhassan.online"
}