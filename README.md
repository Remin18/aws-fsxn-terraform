### ディレクトリ構造
```
.
├── main.tf
├── modules
│   └── fsxn
│       ├── main.tf
│       └── variables.tf
├── terraform.tfvars
└── variables.tf
```

### VPC情報の取得
VPC IDの取得
``` bash
aws ec2 describe-vpcs \
  --query 'Vpcs[*].{VpcId:VpcId,Name:Tags[?Key==`Name`]|[0].Value}'\
  --output text
```

Subnet IDの取得
``` bash
aws ec2 describe-subnets \
  --filters "Name=vpc-id,Values={任意のVPC ID}" \
  --query 'Subnets[*].{SubnetId:SubnetId,Name:Tags[?Key==`Name`]|[0].Value}' \
  --output text
```

### ローカルのワークスペースを初期化
```
terraform init
```

### 変更リソースの確認
```
terraform plan
```

### 変更リソースの確認
```
terraform apply
```

### リソースの破棄
```
terraform destroy
```
