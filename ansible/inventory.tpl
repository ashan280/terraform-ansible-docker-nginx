[web]
${EC2_IP} ansible_user=ec2-user ansible_ssh_private_key_file=Network.pem ansible_ssh_common_args='-o StrictHostKeyChecking=no'
