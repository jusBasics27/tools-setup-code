default:
	git pull
	terraform init -reconfigure
	terraform apply -auto-approve -var vault_token=$(vault_token)