##  Copyright 2023 Google LLC
##  
##  Licensed under the Apache License, Version 2.0 (the "License");
##  you may not use this file except in compliance with the License.
##  You may obtain a copy of the License at
##  
##      https://www.apache.org/licenses/LICENSE-2.0
##  
##  Unless required by applicable law or agreed to in writing, software
##  distributed under the License is distributed on an "AS IS" BASIS,
##  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
##  See the License for the specific language governing permissions and
##  limitations under the License.


##  This code creates demo environment for CSA Model Armor Demo
##  This demo code is not built for production workload ##


variable "ma_project_id" {
  type        = string
  description = "Project ID to deploy resources"
#  default     = "PROJECT_ID"
}


variable "vertex_instance_owner" {
  type        = list(string)
  description = "Vertex workbench instance owner"
#  default     = ["user@domain.com"]
}

variable "network_region" {
  type        = string
  description = "Primary network region"
  default     = "us-central1"
}


variable "vpc_dmz_subnetwork" {
  type        = string
  description = "Subnet range for DMZ subnet"
  default     = "10.10.0.0/24"
}


variable "roles" {
  type        = list(string)
  description = "The roles that will be granted to the service account."
  default     = ["roles/aiplatform.user", "roles/modelarmor.admin", "roles/iam.serviceAccountUser", "roles/storage.objectUser", "roles/serviceusage.serviceUsageConsumer"]
}


variable "ma_dlp_roles" {
  type        = list(string)
  description = "Grant the Model Armor Service Account DLP privileges"
  default     = ["roles/dlp.user", "roles/dlp.reader"]
}
