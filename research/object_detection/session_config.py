# Copyright 2017 The TensorFlow Authors. All Rights Reserved.
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
"""Session configuration for the object detection model in TF.learn.

This file consolidates and documents the  used by the model.
"""

from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

from google.protobuf import text_format

try:
    import tensorflow.compat.v1 as tf
except:
    import tensorflow as tf


def create_session_config(session_config_proto=None):
    """Returns SessionConfig

  Args:

  Returns:
  """
    session_config = tf.ConfigProto()
    if session_config_proto:
        session_config = text_format.Merge(session_config_proto, session_config)
    return session_config
