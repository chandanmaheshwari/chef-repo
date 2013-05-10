#
# Cookbook Name:: hostfile
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#Knife invocations supply FQDN as the node name at creation time and this becomes hostname( option -N)
 
  cookbook_file "/tmp/update_hosts.sh" do
    source "update_hosts.sh"
    owner "root"
    group "root"
    mode 0555
    backup false
  end
 
 
 #Execute this script now (firsttime) to set /etc/hosts to have the newly provisioned nodes address/hostname line
 
  bash "update_hosts" do
    user "root"
    group "root"
    cwd "/tmp"
    code <<-EOH
  
    sh /tmp/update_hosts.sh
    EOH

  end
  