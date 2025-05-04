variable "tools" {

  default={
    vault ={
      # port=8200
      port          = {
        vault_port  = 8200
      }
      volume_size=20
      instance_type="t3.small"
      policy_list = []
    }

    github-runner ={
      # port=80 # dummy port
      port          = {}
      volume_size=80
      instance_type="t3.small"
      policy_list = ["*"]
    }

    elasticsearch ={
      # port=80
      port          = {
        elasticsearch = 9200
        nginx         = 80
        logstash      = 5044
      }
      volume_size=50
      instance_type="r6idn.large"
      policy_list = []
    }
  }
}

variable "zone_id" {
  default="Z0252555OF8RI2R4KATG"
}

variable "domain_name" {
  default="waferhassan.online"
}