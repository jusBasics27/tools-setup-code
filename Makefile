infra:
    @echo "Running terraform..."
	terraform init
	terraform apply -auto-approve

ansible:
    @echo "Running ansible..."
	ansible-playbook -i $(tool_name)-internal.waferhassantool.online, -e ansible_user=ec2-user -e ansible_password=DevOps321 -e tool_name=$(tool_name) -e vault_token=$(vault_token) main.yml

all: infra ansible