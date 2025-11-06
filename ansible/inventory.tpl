[web]
${EC2_PUBLIC_IP} ansible_user=ec2-user ansible_ssh_private_key_file=Network.pem ansible_python_interpreter=/usr/bin/python3.8 ansible_ssh_common_args='-o StrictHostKeyChecking=no'
