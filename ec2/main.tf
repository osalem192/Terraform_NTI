resource "aws_key_pair" "my_key_pair" {
  key_name   = "my-ec2-key"              # Name of the key pair in AWS
  public_key = file("~/.ssh/id_rsa.pub") # Path to your public key file
}

resource "aws_instance" "web" {
  ami             = var.ami_ec2
  instance_type   = "t2.micro"
  security_groups = [var.web_sg_id]
  for_each        = var.public_subnets
  subnet_id       = each.value
  key_name        = aws_key_pair.my_key_pair.key_name
  user_data       = file("./scripts/nginx_install.sh")
  tags = {
    "name" = "public_${each.value}"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user" # Adjust based on your AMI (e.g., ubuntu for Ubuntu AMIs)
    private_key = file("~/.ssh/id_rsa")
    timeout     = "2"

  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install nginx -y",
      "sudo systemctl enable --now nginx",
      "sudo touch /etc/nginx/conf.d/reverse-proxy.conf",
      "sudo bash -c 'cat > /etc/nginx/conf.d/reverse-proxy.conf' << EOF",
      "server {",
      "    listen 80;",
      "    server_name _;",
      "    location / {",
      "        proxy_pass http://${var.private_alb_dns_name};",
      "        proxy_set_header Host \\$host;",
      "        proxy_set_header X-Real-IP \\$remote_addr;",
      "        proxy_set_header X-Forwarded-For \\$proxy_add_x_forwarded_for;",
      "        proxy_set_header X-Forwarded-Proto \\$scheme;",
      "    }",
      "}",
      "EOF",
      "sudo systemctl restart nginx"
    ]
  }
}

resource "aws_instance" "private" {
  ami             = var.ami_ec2
  instance_type   = "t2.micro"
  security_groups = [var.web_sg_id]
  for_each        = var.private_subnets
  subnet_id       = each.value
  key_name        = aws_key_pair.my_key_pair.key_name
  user_data       = file("./scripts/private_${each.key}.sh")
  tags = {
    "name" = "private_${each.value}"
  }

}



# resource "aws_key_pair" "deployer" {
#   key_name   = "aws_key"
#   public_key = file("./id_rsa.pub")
# }
