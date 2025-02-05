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






resource "google_workbench_instance" "ma_veretx_instance" {
  name = "ma-workbench-instance"
  location = "${var.network_region}-a"
    project     = var.ma_project_id


  gce_setup {
    machine_type = "n1-standard-2" // cant be e2 because of accelerator
    vm_image {
      project = "cloud-notebooks-managed"
      family  = "workbench-instances"
    }
   # accelerator_configs {
    #  type         = "NVIDIA_TESLA_T4"
    #  core_count   = 1
    #}

    shielded_instance_config {
      enable_secure_boot = true
      enable_vtpm = true
      enable_integrity_monitoring = true
    }


    disable_public_ip = true

    service_accounts {
      email = "${google_service_account.www.email}"
    }

    boot_disk {
      disk_size_gb  = 200
      disk_type = "PD_SSD"
  #    disk_encryption = "CMEK"
 #     kms_key = "my-crypto-key"
    }

    data_disks {
      disk_size_gb  = 200
      disk_type = "PD_SSD"
 #     disk_encryption = "CMEK"
 #     kms_key = "my-crypto-key"
    }

    network_interfaces {
      network = google_compute_network.vpc_dmz.id
      subnet = google_compute_subnetwork.subnet_dmz.id
      nic_type = "GVNIC"
    #  access_configs {
     #   external_ip = google_compute_address.static.address
    #  }
    }

    metadata = {
      terraform = "true"
      PROJ_ID                    = var.ma_project_id
      LOCATION = var.network_region
      post-startup-script          = "gs://${google_storage_bucket.start_up_bucket.name}/install_script.sh"
    post-startup-script-behavior = "download_and_run_every_start"
    idle-timeout-seconds         = 3600
    notebook-disable-root        = true
    notebook-upgrade-schedule    = "00 19 * * SAT"
    }

   # enable_ip_forwarding = true

    tags = ["vertex", "model-armor"]

  }

  disable_proxy_access = "false"

  instance_owners  = ["admin@manishkgaur.altostrat.com"]

  labels = {
    k = "model-armor"
  }

  desired_state = "ACTIVE"

depends_on = [
google_storage_bucket_object.start_up_notebook,
google_compute_router_nat.cloud_nat_dmz,
time_sleep.wait_enable_service_api,
]

}

