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




resource "null_resource" "set_model_armor_template_all_in_one_low" {

  /*
  triggers = {
    project = var.ma_project_id
    region   = var.network_region
    GCLOUD_AUTH_TOKEN= "$(gcloud auth print-access-token)" 
  }
*/

  provisioner "local-exec" {
    command = <<EOF
    export FILTER_CONFIGURATION="{ \
  'filter_config': { \
  'piAndJailbreakFilterSettings': { \
        'filterEnforcement': 'ENABLED' \
      }, \
  'maliciousUriFilterSettings': { \
        'filterEnforcement': 'ENABLED' \
      }, \
    'rai_settings': { \
      'rai_filters': { \
        'filter_type': 'sexually_explicit', \
        'confidence_level': 'LOW_AND_ABOVE' \
      }, \
      'rai_filters': { \
        'filter_type': 'hate_speech', \
        'confidence_level': 'LOW_AND_ABOVE' \
      },\
      'rai_filters': { \
        'filter_type': 'harassment', \
        'confidence_level': 'LOW_AND_ABOVE' \
      }, \
      'rai_filters': { \
        'filter_type': 'dangerous', \
        'confidence_level': 'LOW_AND_ABOVE' \
      },\
    }, \
    'sdpSettings': {\
      'basicConfig': {\
        'filterEnforcement': 'ENABLED'\
      }\
   }\
  } \
}"

export GCLOUD_AUTH_TOKEN="$(gcloud auth print-access-token)" 

# create
curl -X POST \
 -d  "$FILTER_CONFIGURATION" \
 -H "Content-Type: application/json" \
 -H "Authorization: Bearer $GCLOUD_AUTH_TOKEN"  \
'https://modelarmor.${var.network_region}.rep.googleapis.com/v1alpha/projects/${var.ma_project_id}/locations/${var.network_region}/templates?template_id=all-in-one-low'
    EOF
  }

  /*
  provisioner "local-exec" {
    when    = destroy
    command = "curl -X DELETE -H \"Authorization: Bearer ${self.triggers.GCLOUD_AUTH_TOKEN}\" \"https://modelarmor.${self.triggers.region}.rep.googleapis.com/v1alpha/projects/${self.triggers.project}/locations/${self.triggers.region}/templates?template_id=all-in-one-low\" "
        }
        */

  depends_on = [
    time_sleep.wait_enable_service_api,
    # google_data_loss_prevention_deidentify_template.advanced_dlp_demo_deidentify,
    # google_data_loss_prevention_inspect_template.advanced_dlp_demo_inspect,
  ]
}






resource "null_resource" "set_model_armor_template_all_in_one_med" {

  /*
  triggers = {
    project = var.ma_project_id
    region   = var.network_region
    GCLOUD_AUTH_TOKEN="$(gcloud auth print-access-token)" 
  }
  */

  provisioner "local-exec" {
    command = <<EOF

    export FILTER_CONFIGURATION="{ \
  'filter_config': { \
  'piAndJailbreakFilterSettings': { \
        'filterEnforcement': 'ENABLED' \
      }, \
  'maliciousUriFilterSettings': { \
        'filterEnforcement': 'ENABLED' \
      }, \
    'rai_settings': { \
      'rai_filters': { \
        'filter_type': 'sexually_explicit', \
        'confidence_level': 'MEDIUM_AND_ABOVE' \
      }, \
      'rai_filters': { \
        'filter_type': 'hate_speech', \
        'confidence_level': 'MEDIUM_AND_ABOVE' \
      },\
      'rai_filters': { \
        'filter_type': 'harassment', \
        'confidence_level': 'MEDIUM_AND_ABOVE' \
      }, \
      'rai_filters': { \
        'filter_type': 'dangerous', \
        'confidence_level': 'MEDIUM_AND_ABOVE' \
      },\
    }, \
    'sdpSettings': {\
      'basicConfig': {\
        'filterEnforcement': 'ENABLED'\
      }\
   }\
  } \
}"

#
export GCLOUD_AUTH_TOKEN="$(gcloud auth print-access-token)" 

# create
curl -X POST \
 -d  "$FILTER_CONFIGURATION" \
 -H "Content-Type: application/json" \
 -H "Authorization: Bearer $GCLOUD_AUTH_TOKEN"  \
'https://modelarmor.${var.network_region}.rep.googleapis.com/v1alpha/projects/${var.ma_project_id}/locations/${var.network_region}/templates?template_id=all-in-one-med'

    EOF
  }

  /*
    provisioner "local-exec" {
    when    = destroy
    command = <<EOT
echo "${self.triggers.GCLOUD_AUTH_TOKEN}"

# Delete
curl -X DELETE -H "Authorization: Bearer ${self.triggers.GCLOUD_AUTH_TOKEN}" 'https://modelarmor.${self.triggers.region}.rep.googleapis.com/v1alpha/projects/${self.triggers.project}/locations/${self.triggers.region}/templates?template_id=all-in-one-med'
    EOT
  }
  */



  depends_on = [
    time_sleep.wait_enable_service_api,
    google_data_loss_prevention_deidentify_template.advanced_dlp_demo_deidentify,
    google_data_loss_prevention_inspect_template.advanced_dlp_demo_inspect,
  ]
}




resource "null_resource" "set_model_armor_template_all_in_one_high" {

  /*
  triggers = {
    project = var.ma_project_id
    region   = var.network_region
    GCLOUD_AUTH_TOKEN="$(gcloud auth print-access-token)" 
  }
  */

  provisioner "local-exec" {
    command = <<EOF

    export FILTER_CONFIGURATION="{ \
  'filter_config': { \
  'piAndJailbreakFilterSettings': { \
        'filterEnforcement': 'ENABLED' \
      }, \
  'maliciousUriFilterSettings': { \
        'filterEnforcement': 'ENABLED' \
      }, \
    'rai_settings': { \
      'rai_filters': { \
        'filter_type': 'sexually_explicit', \
        'confidence_level': 'HIGH' \
      }, \
      'rai_filters': { \
        'filter_type': 'hate_speech', \
        'confidence_level': 'HIGH' \
      },\
      'rai_filters': { \
        'filter_type': 'harassment', \
        'confidence_level': 'HIGH' \
      }, \
      'rai_filters': { \
        'filter_type': 'dangerous', \
        'confidence_level': 'HIGH' \
      },\
    }, \
    'sdpSettings': {\
      'basicConfig': {\
        'filterEnforcement': 'ENABLED'\
      }\
  } \
}
    }"


export GCLOUD_AUTH_TOKEN="$(gcloud auth print-access-token)" 


# create
curl -X POST \
 -d  "$FILTER_CONFIGURATION" \
 -H "Content-Type: application/json" \
 -H "Authorization: Bearer $GCLOUD_AUTH_TOKEN"  \
'https://modelarmor.${var.network_region}.rep.googleapis.com/v1alpha/projects/${var.ma_project_id}/locations/${var.network_region}/templates?template_id=all-in-one-high'

    EOF
  }

  /*
      provisioner "local-exec" {
    when    = destroy
    command = <<EOT
echo "${self.triggers.GCLOUD_AUTH_TOKEN}"

# create
curl -X DELETE \
-H "Authorization: Bearer ${self.triggers.GCLOUD_AUTH_TOKEN}"  \
'https://modelarmor.${self.triggers.region}.rep.googleapis.com/v1alpha/projects/${self.triggers.project}/locations/${self.triggers.region}/templates?template_id=all-in-one-high'
    EOT

      }
      */




  depends_on = [
    time_sleep.wait_enable_service_api,
    google_data_loss_prevention_deidentify_template.advanced_dlp_demo_deidentify,
    google_data_loss_prevention_inspect_template.advanced_dlp_demo_inspect,
  ]
}








/*


resource "null_resource" "set_model_armor_template_advanced_dlp" {
  provisioner "local-exec" {
    command = <<EOF
export FILTER_CONFIGURATION="{ \
  'filter_config': { \
    'sdpSettings': {\
      'advancedConfig': {\
        'inspectTemplate': 'projects/${var.ma_project_id}/locations/us-central1/inspectTemplates/advanced-dlp-demo-inspect'\
        'deidentifyTemplate': 'projects/${var.ma_project_id}/locations/us-central1/deidentifyTemplates/advanced-dlp-demo-deidentify'\
      }\
   }\
  } \
}"

export GCLOUD_AUTH_TOKEN="$(gcloud auth print-access-token)" 


# create
curl -X POST \
 -d  "$FILTER_CONFIGURATION" \
 -H "Content-Type: application/json" \
 -H "Authorization: Bearer $GCLOUD_AUTH_TOKEN"  \
'https://modelarmor.${var.network_region}.rep.googleapis.com/v1alpha/projects/${var.ma_project_id}/locations/${var.network_region}/templates?template_id=advanced-dlp'

    EOF
  }
    depends_on = [
    time_sleep.wait_enable_service_api,
    google_data_loss_prevention_deidentify_template.advanced_dlp_demo_deidentify,
    google_data_loss_prevention_inspect_template.advanced_dlp_demo_inspect,
  ]
}


*/
