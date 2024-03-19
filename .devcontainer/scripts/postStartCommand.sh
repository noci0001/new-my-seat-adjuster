#!/bin/bash

# Copyright (c) 2023-2024 Contributors to the Eclipse Foundation
#
# This program and the accompanying materials are made available under the
# terms of the Apache License, Version 2.0 which is available at
# https://www.apache.org/licenses/LICENSE-2.0.
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
#
# SPDX-License-Identifier: Apache-2.0

set -e

echo "               ▒▒▒▒▒▒▒▒▒
         ▓▓▓▓▓▓▓▓▓▓▓▓▓ ▒▒▒              ▓▓ ▒▒
    █▓▓▓▓▓▓▓▓▓▓▓ ▓▓▓  ▓▓  ▒▒       ▓▓▓▓ ▓▓▒▒
  ██       ███  ▓▓  ▓▓  ▓▓ ▒▒   ██ ▓ ▓▓▓▓▒▒
              ███ ▓▓ ▓▓▓ ▓▓  ▒▒ ██▓▓▓▓ ▓▒▒
                ██  ▓▓ ▓▓ ▓▓▓ ▒▒█ ▓▓▓▓▓▒▒                           ▓▓                       ▓▓▓
                  ██ ▓▓ ▓▓  ▓▓ ▒▒ ▓▓▓▓▒▒    ▓▓       ▓▓             ▓▓                             ▓▓
                   ██ ▓▓ ▓▓  ▓▓█▒▒▓▓▓▒▒      ▓▓     ▓▓   ▓▓▓▓▓▓▓    ▓▓   ▓▓▓▓▓▓▓    ▓▓▓▓▓▓▓  ▓▓  ▓▓▓▓▓▓▓   ▓▓▓▓▓▓▓   ▓▓▓▓▓▓▓▓
                    ██ ▓▓ ▓▓  ▓▓█▓▓▓▓         ▓▓   ▓▓▓  ▓▓▓    ▓▓   ▓▓  ▓▓     ▓▓  ▓▓        ▓▓    ▓▓           ▓▓   ▓▓
                     ██ ▓▓ ▓▓  ▓▓▓▓▓          ▓▓   ▓▓   ▓▓▓▓▓▓▓▓▓   ▓▓  ▓▓     ▓▓  ▓▓        ▓▓    ▓▓      ▓▓▓▓▓▓▓   ▓▓▓▓▓
                      ██ ▓▓ ▓▓██▓▓             ▓▓ ▓▓    ▓▓▓         ▓▓  ▓▓     ▓▓  ▓▓        ▓▓    ▓▓     ▓▓    ▓▓        ▓▓▓
                       ██ ▓▓  ▓▓▓              ▓▓▓▓▓    ▓▓▓         ▓▓  ▓▓▓    ▓▓  ▓▓▓       ▓▓    ▓▓     ▓▓    ▓▓         ▓▓
                        ██ ▓▓ █▓                ▓▓▓       ▓▓▓▓▓▓▓   ▓▓    ▓▓▓▓▓      ▓▓▓▓▓▓  ▓▓      ▓▓▓    ▓▓▓ ▓▓   ▓▓▓▓▓▓
                         ██  ██
                          ████
"

echo "###########################################"
echo "#  Creating your Vehicle App              #"
echo "###########################################"

# start fresh, regardless of cached data
sudo rm -rf ~/.velocitas

# Ensure all files within the mounted Git repo are owned by the current user
# (should be "vscode"). This is required for devContainers running on Windows
# + WSL2, where mounted files/folders "appear as if they are owned by root"
# (see https://code.visualstudio.com/remote/advancedcontainers/add-nonroot-user)
shopt -s extglob
sudo chown -R $(id -u):$(id -g) ./!(.git)

velocitas create $VELOCITAS_CREATE_ARGS

# Since we kind of hijack the same devContainer and these directories
# might have been created by a different user ID, we make sure to delete
# cached velocitas packages in order to avoid conflicts.
sudo rm -rf ~/.velocitas

echo "###########################################"
echo "# DONE! Please rebuild your devContainer. #"
echo "###########################################"
