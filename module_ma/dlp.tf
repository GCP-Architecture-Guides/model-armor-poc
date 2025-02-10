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








resource "google_data_loss_prevention_inspect_template" "advanced_dlp_demo_inspect" {
  provider     = google.service
  parent       = "projects/${var.ma_project_id}/locations/${var.network_region}"
  description  = "For use with Model Armor"
  display_name = "Advanced DLP Demo inspect template"
  template_id  = "advanced-dlp-demo-inspect"

  inspect_config {
    info_types {
      name = "EMAIL_ADDRESS"
    }
    info_types {
      name = "FINANCIAL_ACCOUNT_NUMBER"
    }
    info_types {
      name = "IMSI_ID"
    }
    info_types {
      name = "IP_ADDRESS"
    }
    info_types {
      name = "PHONE_NUMBER"
    }
    info_types {
      name = "CANADA_BANK_ACCOUNT"
    }
    info_types {
      name = "CANADA_DRIVERS_LICENSE_NUMBER"
    }
    info_types {
      name = "CANADA_PASSPORT"
    }
    info_types {
      name = "CANADA_SOCIAL_INSURANCE_NUMBER"
    }
    info_types {
      name = "MEDICAL_RECORD_NUMBER"
    }
    info_types {
      name = "CVV_NUMBER"
    }
    info_types {
      name = "CREDIT_CARD_TRACK_NUMBER"
    }
    info_types {
      name = "CREDIT_CARD_NUMBER"
    }



    min_likelihood = "LIKELY"

  }

  depends_on = [
    time_sleep.wait_enable_service_api,
  ]
}




resource "google_data_loss_prevention_deidentify_template" "advanced_dlp_demo_deidentify" {
  provider     = google.service
  parent       = "projects/${var.ma_project_id}/locations/${var.network_region}"
  description  = "For use with Model Armor"
  display_name = "Advanced DLP Demo de-identify template"
  template_id  = "advanced-dlp-demo-deidentify"

  deidentify_config {
    info_type_transformations {
      transformations {
        primitive_transformation {
          replace_with_info_type_config = true
        }
      }

    }
  }
  depends_on = [
    time_sleep.wait_enable_service_api,
  ]
}

