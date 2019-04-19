provider "aws" {
  region = "eu-central-1"
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  default = 5000
}

variable "key_pair_name" {
  description = "The EC2 Key Pair to associate with the EC2 Instance for SSH access."
  default = "my-keypair"
}

variable "key_pair" {
  description = "The keypair to use to authenticate clients SSH-ing into the EC2 instances"
}

variable "db_user" {
  description = "Choose the database username"
  default = "smallface"
}

variable "db_password" {
  description = "Choose the database password"
}

resource "aws_security_group" "smallface-sg" {
  name = "smallface-security-group"

  ingress {
    from_port = "${var.server_port}"
    to_port = "${var.server_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "5432"
    to_port = "5432"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "db" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "11.1"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "${var.db_user}"
  password             = "${var.db_password}"
  vpc_security_group_ids = ["${aws_security_group.smallface-sg.id}"]
}

resource "aws_instance" "server" {
  ami = "ami-09def150731bdbcc2"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.smallface-sg.id}"]
  key_name = "${var.key_pair_name}"

  connection {
    host="${aws_instance.server.public_dns}"
    user = "ec2-user"
    port = 22
    private_key = "${file(var.key_pair)}"
    timeout = "1m"
    agent = false
  }

  provisioner "file" {
    source = "target/smallface.jar"
    destination = "/tmp/smallface.jar"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y java-1.8.0",
      "cd /tmp",
      "export SPRING_ACTIVE_PROFILES=prod",
      "export SPRING_DATASOURCE_URL=jdbc:postgresql://${aws_db_instance.db.address}:${aws_db_instance.db.port}/${aws_db_instance.db.name}",
      "export SPRING_DATASOURCE_USERNAME=${var.db_user}",
      "export SPRING_DATASOURCE_PASSWORD=${var.db_password}",
      "java -jar smallface.jar > log.txt &"
    ]
  }
}

output "smallface-url" {
  value = "http://${aws_instance.server.public_dns}:${var.server_port}"
}

