#!/bin/bash
# Copyright 2019 The TensorFlow Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ==============================================================================
set -e
set -x

source tensorflow/tools/ci_build/release/common.sh

sudo pip install --upgrade twine

# Copy and rename to tf_nightly
for f in $(ls "${TF_FILE_DIR}"/tf_nightly_cpu*dev*cp3*-cp3*m-win_amd64.whl); do
  copy_to_new_project_name "${f}" tf_nightly
done

# Upload the built packages to pypi.
for f in $(ls "${TF_FILE_DIR}"/tf_nightly*dev*cp3*-cp3*m-win_amd64.whl); do
  twine upload -r pypi-warehouse "$f" || echo
done
