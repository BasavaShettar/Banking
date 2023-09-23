provider "aws" {
region     = "us-east-1" 
}

resource "aws_instance" "web-server" {
  ami           = "ami-053b0d53c279acc90" 
  instance_type = "t2.micro" 
  key_name = "NewKey"
  vpc_security_group_ids= ["sg-030721246fc4012b2"]
 
 connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("./NewKey.pem")
    host     = self.public_ip
  }
  
  provisioner "remote-exec" {
    inline = [ "echo 'wait to start instance' "]
  }
  
  tags = {
    Name = "web-server"
  }
  
  provisioner "local-exec" {
        command = " echo ${aws_instance.web-server.public_ip} > inventory "
        command = " touch Hello"
  }
  # provisioner "local-exec" {
  #command = "ansible-playbook /var/lib/jenkins/workspace/Banking/my-serverfiles/finance-playbook.yml "
  } 
}
