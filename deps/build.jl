# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

using JSON
using Libdl
using LinearAlgebra

################################################################################
# First try to detect and load existing libmxnet
################################################################################
libmxnet_detected = false
libmxnet_curr_ver = get(ENV, "MXNET_COMMIT", "master")
curr_win = "20180211"  # v1.1.0

if haskey(ENV, "MXNET_HOME")
  MXNET_HOME = ENV["MXNET_HOME"]
  @info("MXNET_HOME environment detected: $MXNET_HOME")
  @info("Trying to load existing libmxnet...")
  # In case of macOS, if user build libmxnet from source and set the MXNET_HOME,
  # the output is still named as `libmxnet.so`.
  lib = Libdl.find_library(["libmxnet.$(Libdl.dlext)", "libmxnet.so"])
  if !isempty(lib)
    @info("Existing libmxnet detected at $lib, skip building...")
    libmxnet_detected = true
  else
    error("Failed to load existing libmxnet")
  end
end

