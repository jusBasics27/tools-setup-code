resource "aws_security_group" "sg" {
  name        = "${var.tool_name}-sg"
  description = "Inbound allow for ${var.tool_name}"
  # vpc_id = var.vpc_id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  # ingress {
  #   from_port        = var.sg_port
  #   to_port          = var.sg_port
  #   protocol         = "TCP"
  #   cidr_blocks      = ["0.0.0.0/0"]
  # }

  dynamic "ingress" {
    for_each = var.sg_port
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
      description = ingress.key
    }
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags={
    Name="${var.tool_name}-sg"
  }

}

resource "aws_instance" "inst" {
  ami=data.aws_ami.ami.id
  instance_type=var.instance_type
  # subnet_id = "subnet-03ad7ee1155f25700"
  vpc_security_group_ids=[aws_security_group.sg.id]
  # associate_public_ip_address = true
  tags={
    Name=var.tool_name
  }
  root_block_device {  # This is give the volume size of the machine like 20GB/40GB
    volume_size = var.volume_size
  }
  instance_market_options {  # Create SPOT instances
    market_type = "spot"
    spot_options {
      instance_interruption_behavior = "stop"
      spot_instance_type = "persistent"
    }
  }
  iam_instance_profile = length(var.policy_list) > 0 ? aws_iam_instance_profile.instance_profile[0].name : null
}
# note: iam_instance_profile this is to attach the instance profile role to instance

# Creating 2 records, using public i can access thru browser
resource "aws_route53_record" "record-public" {
  zone_id = var.zone_id
  name    = "${var.tool_name}.${var.domain_name}"
  type    = "A"
  ttl     = "30"
  records = [aws_instance.inst.public_ip]
}


resource "aws_route53_record" "record-internal" {
  zone_id = var.zone_id
  name    = "${var.tool_name}-internal.${var.domain_name}"
  type    = "A"
  ttl     = "30"
  records = [aws_instance.inst.private_ip]
}
