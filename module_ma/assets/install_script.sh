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

#!/bin/bash
 
 
sudo apt-get update -y 

echo "Current user: uid=1000(admin_) gid=1000(admin_) groups=1000(admin_),4(adm),27(sudo),999(docker)" >> /tmp/notebook_config.log 2>&1
  echo "Changing dir to /home/jupyter" >> /tmp/notebook_config.log 2>&1
  export PATH="/home/jupyter/.local/bin:/home/admin_/.local/bin:/opt/gradle/bin:/opt/maven/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/go/bin:/usr/local/rvm/bin:/google/go_appengine:/google/google_appengine:/google/migrate/anthos/:/home/admin_/.gems/bin:/usr/local/rvm/bin:/home/admin_/gopath/bin:/google/gopath/bin:/google/flutter/bin:/usr/local/nvm/versions/node/v20.11.1/bin"
  cd /home/jupyter
  echo "Current user: uid=1000(admin_) gid=1000(admin_) groups=1000(admin_),4(adm),27(sudo),999(docker)" >> /tmp/notebook_config.log 2>&1
  echo "Installing python packages" >> /tmp/notebook_config.log 2&1
  su - jupyter -c "pip install --trusted-host pypi.org     --trusted-host pypi.python.org --trusted-host     files.pythonhosted.org pip setuptools" >> /tmp/notebook_config.log 2>&1
  su - jupyter -c "pip install --upgrade --no-warn-conflicts --no-warn-script-location --user       google-cloud-bigquery       google-cloud-pipeline-components       google-cloud-aiplatform       seaborn       kfp" >> /tmp/notebook_config.log 2>&1
  sudo git clone https://github.com/GCP-Architecture-Guides/model-armor-poc.git
  cp model-armor-poc/module_ma/assets/*.ipynb /home/jupyter/
  sudo rm notebook_template.ipynb 
  sudo rm model-armor-poc -r -f

 
