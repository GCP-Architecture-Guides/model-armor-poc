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





#Creating the storage bucket for our static images
resource "google_storage_bucket" "model_armor_bucket" {
  name                        = "model-armor-bucket-${random_id.random_suffix.hex}"
  location                    = var.network_region
  force_destroy               = true
  project                     = var.ma_project_id
  uniform_bucket_level_access = true
  depends_on = [
    time_sleep.wait_enable_service_api,
  ]
}



# Add bank image to the bucket
resource "google_storage_bucket_object" "bank_image" {
  name   = "bank.png"
  bucket = google_storage_bucket.model_armor_bucket.name
  source = "${path.module}/assets/bank.png"
  depends_on = [
    google_storage_bucket.model_armor_bucket,
  ]
}


# Add bank image to the bucket
resource "google_storage_bucket_object" "teller_image" {
  name   = "teller.png"
  bucket = google_storage_bucket.model_armor_bucket.name
  source = "${path.module}/assets/teller.png"
  depends_on = [
    google_storage_bucket.model_armor_bucket,
  ]
}






####################################### Start-up Script ##############################


resource "google_storage_bucket" "start_up_bucket" {
  project                     = var.ma_project_id
  name                        = "vertex-startup-bucket-${random_id.random_suffix.hex}"
  location                    = var.network_region
  force_destroy               = true
  uniform_bucket_level_access = true
  depends_on                  = [time_sleep.wait_enable_service_api]
}




# Add startup file to bucket
resource "google_storage_bucket_object" "start_up_notebook" {
  name   = "install_script.sh"
  bucket = google_storage_bucket.start_up_bucket.name
  source = "${path.module}/assets/install_script.sh"
  depends_on = [
    google_storage_bucket.start_up_bucket,
  ]
}
