#
# Cookbook Name:: plms_app
# Recipe:: production
#
# Copyright 2008-2011, Opscode, Inc.
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

# Include Opscode helper in Recipe class to get access
# to debian_before_squeeze? and ubuntu_before_lucid?
#::Chef::Recipe.send(:include, Opscode::Mysql::Helpers)


#package_file = node['mysql']['client']['package_file']
package_file = "fusion-webapp-3.2-SNAPSHOT.war"
  remote_file "#{Chef::Config[:file_cache_path]}/#{package_file}" do
    #source node['mysql']['client']['url']
	source "https://ssp.ptc.com/builds/browse/PRECISION-FUSION1-27/artifact/JOB1/LMS-WAR/#{package_file}"
    not_if { File.exists? "#{Chef::Config[:file_cache_path]}/#{package_file}" }
  end