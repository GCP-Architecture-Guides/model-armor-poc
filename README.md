# GenAI Security Model Armor Demo


This is not an officially supported Google product documentation.
This code creates a secure demo environment for Model Armor. This demo code is not built for production workload. 


# Demo 
This demo uses terraform to setup sModel Armor demo in a Vertex AI Wrokbench  in a project and underlying infrastructure using Google Cloud Services like [Model Armor](https://cloud.google.com/security-command-center/docs/model-armor-overview),  [Vertex-AI](https://cloud.google.com/vertex-ai), [Cloud Compute Engine](https://cloud.google.com/compute) and [Cloud Logging](https://cloud.google.com/logging).



## What resources are created?
Main resources:
- One VPC network
- Vertex AI Workbench Instance
- Model Armor Policies




## How to deploy?
The following steps should be executed in Cloud Shell in the Google Cloud Console. 


### 1. IAM Permission 
Grant the user running the terraform below roles.
``` 
Model Armor Admin
Policy Administrator
```


### 2. Get the code
Clone this github repository go to the root of the repository.

``` 
git clone https://github.com/GCP-Architecture-Guides/model-armor-poc.git
cd model-armor-poc
```

### 3. Deploy the infrastructure using Terraform


From the root folder of this repo, run the following commands:

```
export TF_VAR_ma_project_id=[YOUR_PROJECT_ID]
export TF_VAR_vertex_insance_owner= [VERTEX_INSTANCE_OWNER_EMAIL]
export TF_VAR_network_region=[YOUR_NETWORK_REGION]
terraform init
terraform apply
terraform apply --refresh-only
```



**Note:** All the other variables are give a default value. If you wish to change, update the corresponding variables in variable.tf file.



## How to clean-up?

From the root folder of this repo, run the following command:
```
terraform destroy
```
**Note:** If you get an error while destroying, it is likely due to delay in VPC-SC destruction rollout. Just execute terraform destroy again, to continue clean-up.
