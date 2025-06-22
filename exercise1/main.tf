data "aws_ami" "ubuntu_latest" {
  most_recent = true

  filter {
    name = "name"
    # change according to version pin strictness
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "app_server" {
  # Startup script depends on ubuntu user being present
  # CARE: update startup script user, if switching to different AMI
  ami           = data.aws_ami.ubuntu_latest.id
  instance_type = "t2.micro"

  # Creates file in default user directory
  #
  # Default users for distros can be found at
  # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/managing-users.html#ami-default-user-names
  #
  # ~ubuntu is tilde expansion - expands username into its homedir
  # https://www.gnu.org/software/bash/manual/html_node/Tilde-Expansion.html
  #
  # Should this script amass more lines, move it into its own file
  user_data = <<EOF
#!/bin/bash
echo 'foo' > ~ubuntu/hello-world.txt
  EOF

  tags = {
    Name = "ExampleAppServerInstance"
  }
}
