#
# Copyright 2012-2014 Chef Software, Inc.
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
#

name "test-kitchen"
default_version "master"
relative_path "test-kitchen"

source git: "git://github.com/test-kitchen/test-kitchen"

if windows?
  dependency "ruby-windows"
  dependency "ruby-windows-devkit"
else
  dependency "ruby"
end

dependency "rubygems"
dependency "nokogiri"
dependency "bundler" # Added, dep order sometimes hit test-kitchen before bundler
dependency "appbundler" # Added, dep order sometimes hit test-kitchen before appbundler

build do
  env = with_standard_compiler_flags(with_embedded_path)

  bundle "install --without guard", env: env
  bundle "exec rake build", env: env

  gem "install pkg/test-kitchen-*.gem" \
      " --no-ri --no-rdoc", env: env

  appbundle 'test-kitchen'
end
