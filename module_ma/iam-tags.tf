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





data "google_project" "ma_project" {
  project_id = var.ma_project_id

}

########################### IAM Tags#############

resource "google_tags_tag_key" "role_dmz" {
  parent     = "projects/${data.google_project.ma_project.number}"
  short_name = "role-dmz"

  description = "Role of the VM this tag is applied to"
  purpose     = "GCE_FIREWALL"
  purpose_data = {
    network = "${var.ma_project_id}/${google_compute_network.vpc_dmz.name}"
  }
  depends_on = [
    time_sleep.wait_enable_service_api,
    google_compute_network.vpc_dmz,
  ]
}

resource "google_tags_tag_value" "role_dmz" {
  parent      = "tagKeys/${google_tags_tag_key.role_dmz.name}"
  short_name  = "www"
  description = "WWW server"
  depends_on = [
    google_tags_tag_key.role_dmz,
  ]
}
