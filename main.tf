##  Copyright 2025 Google LLC
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


module "module_ma" {
  source               = "./module_ma"
  ma_project_id        = var.ma_project_id
  network_region       = var.network_region
  vpc_dmz_subnetwork   = var.vpc_dmz_subnetwork
  roles                = var.roles
  ma_dlp_roles         = var.ma_dlp_roles
  vertex_instance_owner = var.vertex_instance_owner

}
