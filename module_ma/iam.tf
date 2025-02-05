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


# For the WWW server to use Model Armor
resource "google_service_account" "www" {
  project      = var.ma_project_id
  account_id   = "www-${random_id.random_suffix.hex}"
  display_name = "www"
}



resource "google_project_iam_member" "sa_www" {
  for_each = toset(var.roles)

  project = var.ma_project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.www.email}"

}



resource "google_project_iam_member" "sa_ma" {
  for_each = toset(var.ma_dlp_roles)

  project = var.ma_project_id
  role    = each.value
  member  = "serviceAccount:service-${data.google_project.ma_project.number}@gcp-sa-modelarmor.iam.gserviceaccount.com"
  depends_on = [
    resource.null_resource.set_model_armor_template_all_in_one_low,
    resource.null_resource.set_model_armor_template_all_in_one_med,
    resource.null_resource.set_model_armor_template_all_in_one_high,
    #resource.null_resource.set_model_armor_template_advanced_dlp,
  ]
}
