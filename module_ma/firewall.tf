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



resource "google_compute_network_firewall_policy" "fwpol_dmz" {
  name = "fwpol-dmz"

  description = "Firewall policy for the DMZ VPC"
  project     = var.ma_project_id

  depends_on = [
    time_sleep.wait_enable_service_api,
  ]
}


resource "google_compute_network_firewall_policy_association" "fwpol_dmz_association" {
  name              = "fwpol-dmz-association"
  attachment_target = google_compute_network.vpc_dmz.id
  firewall_policy   = google_compute_network_firewall_policy.fwpol_dmz.name
  project           = var.ma_project_id
}




resource "google_network_security_address_group" "iap" {

  name        = "iap"
  parent      = "projects/${var.ma_project_id}"
  location    = "global"
  description = "Identity-Aware Proxy Source IPs"
  type        = "IPV4"
  capacity    = "1"
  items       = ["35.235.240.0/20"]
  depends_on = [
    time_sleep.wait_enable_service_api,
  ]
}

resource "google_network_security_address_group" "hc_glb_grp" {

  name        = "hc-glb-grp"
  parent      = "projects/${var.ma_project_id}"
  location    = "global"
  description = "Global Load Balancer and Health Check Source IPs"
  type        = "IPV4"
  capacity    = "2"
  items       = ["35.191.0.0/16", "130.211.0.0/22"]
  depends_on = [
    time_sleep.wait_enable_service_api,
  ]
}



# Allow access from Identity-Aware Proxy
resource "google_compute_network_firewall_policy_rule" "allow_iap" {
  project         = var.ma_project_id
  action          = "allow"
  description     = "Allow access from Identity-Aware Proxy"
  direction       = "INGRESS"
  disabled        = false
  enable_logging  = true
  firewall_policy = google_compute_network_firewall_policy.fwpol_dmz.name
  priority        = 1000
  rule_name       = "allow-iap"
  #  target_service_accounts = ["emailAddress:my@service-account.com"]
  target_secure_tags {
    name = "tagValues/${google_tags_tag_value.role_dmz.name}"
  }


  match {
    #  src_ip_ranges = ["35.235.240.0/20"]
    src_address_groups = [google_network_security_address_group.iap.id]

    layer4_configs {
      ip_protocol = "tcp"
      ports       = [22]
    }
  }
  depends_on = [
    google_compute_network_firewall_policy.fwpol_dmz,
    google_tags_tag_value.role_dmz,
    google_compute_network_firewall_policy_association.fwpol_dmz_association,
    google_network_security_address_group.iap,
  ]
}






# allow access from health check ranges
resource "google_compute_network_firewall_policy_rule" "allow_health_check_glb" {
  project         = var.ma_project_id
  action          = "allow"
  description     = "Allow GLB and HC"
  direction       = "INGRESS"
  disabled        = false
  enable_logging  = true
  firewall_policy = google_compute_network_firewall_policy.fwpol_dmz.name
  priority        = 2000
  rule_name       = "allow-iap"
  #  target_service_accounts = ["emailAddress:my@service-account.com"]
  target_secure_tags {
    name = "tagValues/${google_tags_tag_value.role_dmz.name}"
  }


  match {
    #  src_ip_ranges = ["35.235.240.0/20"]
    src_address_groups = [google_network_security_address_group.hc_glb_grp.id]

    layer4_configs {
      ip_protocol = "tcp"
      ports       = [80]
    }
  }
  depends_on = [
    google_compute_network_firewall_policy.fwpol_dmz,
    google_tags_tag_value.role_dmz,
    google_compute_network_firewall_policy_association.fwpol_dmz_association,
    google_network_security_address_group.iap,
  ]
}
