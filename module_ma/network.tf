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


# Create a  DMZ VPC Network
resource "google_compute_network" "vpc_dmz" {
  name = "vpc-dmz"
  #  provider                = google-beta
  auto_create_subnetworks         = false
  delete_default_routes_on_create = false
  project                         = var.ma_project_id
  depends_on = [
    time_sleep.wait_enable_service_api,
  ]
}





# Create a  DMZ sub-Network
resource "google_compute_subnetwork" "subnet_dmz" {
  name = "subnet-dmz"
  #  provider      = google-beta
  ip_cidr_range = var.vpc_dmz_subnetwork
  region        = var.network_region
  network       = google_compute_network.vpc_dmz.id
  project       = var.ma_project_id
  # Enabling VPC flow logs
  # log_config {
  #   aggregation_interval = "INTERVAL_10_MIN"
  #   flow_sampling        = 0.5
  #   metadata             = "INCLUDE_ALL_METADATA"
  # }
  # Enable private Google acces
  private_ip_google_access = true
  depends_on = [
    google_compute_network.vpc_dmz,
  ]
}




# Create a CloudRouter for the DMZ network
resource "google_compute_router" "cr_dmz" {
  project = var.ma_project_id
  name    = "cr-dmz"
  region  = var.network_region
  network = google_compute_network.vpc_dmz.id

  bgp {
    asn = 64514
  }
  depends_on = [
    google_compute_network.vpc_dmz,
  ]
}

# Create a Cloud NAT for the DMZ network
resource "google_compute_router_nat" "cloud_nat_dmz" {
  project                            = var.ma_project_id
  name                               = "cloud-nat-dmz"
  router                             = google_compute_router.cr_dmz.name
  region                             = google_compute_router.cr_dmz.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.subnet_dmz.self_link
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  log_config {
    enable = true
    filter = "ALL"
  }
  depends_on = [
    google_compute_router.cr_dmz,
    google_compute_subnetwork.subnet_dmz,
  ]
}