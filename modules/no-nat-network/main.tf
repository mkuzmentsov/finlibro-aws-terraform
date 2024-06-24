//@formatter:off
data "aws_instance" "finlibro-integrations-instance" {
    depends_on = [
        var.finlibro-integrations-eb-arn
    ]
    filter {
        name   = "tag:Name"
        values = ["FinLibro-Integrations"]
    }
    filter {
        name   = "instance-state-name"
        values = ["running"]
    }
}

resource "aws_eip_association" "eip_assoc" {
    instance_id   = data.aws_instance.finlibro-integrations-instance.id
    allocation_id = var.finlibro-nat-eip-allocation-id
}
//@formatter:on
