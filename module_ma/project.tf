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






resource "random_id" "random_suffix" {
  byte_length = 6
}



# Enable the necessary API services
resource "google_project_service" "api_service" {
  for_each = toset([
    "storage.googleapis.com",
    "compute.googleapis.com",
    "aiplatform.googleapis.com",
    "modelarmor.googleapis.com",
    "dlp.googleapis.com",
    "networksecurity.googleapis.com", ## To use address_groups
    "notebooks.googleapis.com",
    "cloudkms.googleapis.com",
    "iap.googleapis.com",
  ])

  service                    = each.key
  project                    = var.ma_project_id
  disable_on_destroy         = false
  disable_dependent_services = true
  # depends_on = [google_project.micro_seg_project]

}


# Wait delay after enabling APIs
resource "time_sleep" "wait_enable_service_api" {
  depends_on       = [google_project_service.api_service]
  create_duration  = "45s"
  destroy_duration = "45s"
}
