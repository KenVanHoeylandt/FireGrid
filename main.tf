provider "aws" {
	access_key = "${var.aws_access_key_id}"
	secret_key = "${var.aws_access_key_secret}"
	region = "${var.aws_region}"
}

resource "aws_instance" "worker" {
	ami = "${var.aws_worker_ami}"
	instance_type = "${var.aws_worker_instance_type}"
	count = "${var.worker_count}"
	key_name = "${var.aws_ssh_key_name}"
	associate_public_ip_address = true
	vpc_security_group_ids = ["${aws_security_group.firegrid.id}"]
	subnet_id = "${aws_subnet.firegrid.id}"

	tags {
		Name = "firegrid-worker-${count.index+1}"
		Role = "firegrid-worker"
	}

	provisioner "remote-exec" {
		inline = [
			"ls -l"
		]
		connection {
			user = "${var.aws_private_key_user}"
			private_key = "${var.aws_private_key_file}"
		}
	}
}

resource "null_resource" "ansible-provisioning" {
	depends_on = ["aws_instance.worker"]

	triggers {
		cluster_instance_ids = "${join(",", aws_instance.worker.*.id)}"
		minion_instance_ids = "${join(",", aws_instance.worker.*.id)}"
	}

	provisioner "local-exec" {
		command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --inventory-file=`which terraform-inventory` --private-key=${var.aws_private_key_file} -u ${var.aws_private_key_user} --ssh-common-args='-o UserKnownHostsFile=/dev/null' ansible/master.yaml"
	}
}