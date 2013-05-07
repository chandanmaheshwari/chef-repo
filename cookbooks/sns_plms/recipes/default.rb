#
# Cookbook Name:: sns_plms
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Create necessary directories

directory "/d00/apps/plms" do
    mode 00775
    owner "root"
    group "root"
    action :create
    recursive true
  end

  directory "/d00/apps/plms/data/properties" do
    mode 00775
    owner "root"
    group "root"
    action :create
    recursive true
  end
  
  directory "/d00/scripts" do
    mode 00775
    owner "root"
    group "root"
    action :create
    recursive true
  end
  
  directory "/d00/searchindex" do
    mode 00775
    owner "root"
    group "root"
    action :create
  end
  
  directory "/d00/war" do
    mode 00775
    owner "root"
    group "root"
    action :create
  end
  

# Set variables  
src_filename_java = "java.tar"
src_filepath_java = "http://profcontent.ptc.com/java.tar"
extract_path_java = "/d00/apps"

src_filename_tomcat = "tomcat.tar"
src_filepath_tomcat = "http://profcontent.ptc.com/tomcat.tar"
extract_path_tomcat = "/d00/apps/plms"

src_filename_plms = "plms.war"
src_filepath_plms = "http://profcontent.ptc.com/plms.war"
extract_path_plms = "/d00/war"

src_filename_settings = "settings.tar"
src_filepath_settings = "http://profcontent.ptc.com/settings.tar"
extract_path_settings = "/d00/apps/plms/data/properties"

src_filename_scripts = "scripts.tar"
src_filepath_scripts = "http://profcontent.ptc.com/scripts.tar"
extract_path_scripts = "/d00/scripts"

#  remote_file "/d00/jdk1.6.0_14.tar" do
#    source "http://profcontent.ptc.com/jdk1.6.0_14.tar"
#    owner 'root'
#    group 'root'
#    mode 00644
#  end

# Copy the different files from profcontent
  remote_file "/tmp/#{src_filename_java}" do
    source "#{src_filepath_java}"
    owner 'root'
    group 'root'
    mode 00644
  end
  
  remote_file "/tmp/#{src_filename_tomcat}" do
    source "#{src_filepath_tomcat}"
    owner 'root'
    group 'root'
    mode 00644
  end
  
#remote_file "/d00/apps/plms.war" do
#    source "http://profcontent.ptc.com/plms.war"
#    owner 'root'
#    group 'root'
#    mode 00644
#  end

  remote_file "/tmp/#{src_filename_plms}" do
    source "#{src_filepath_plms}"
    owner 'root'
    group 'root'
    mode 00644
  end 
  
  remote_file "/tmp/#{src_filename_settings}" do
    source "#{src_filepath_settings}"
    owner 'root'
    group 'root'
    mode 00644
  end 
  
  remote_file "/tmp/#{src_filename_scripts}" do
    source "#{src_filepath_scripts}"
    owner 'root'
    group 'root'
    mode 00644
  end 
 
#remote_file src_filepath do
#  source node['nginx']['foo123']['url']
#  checksum node['nginx']['foo123']['checksum']
#  owner 'root'
#  group 'root'
#  mode 00644
#end

# Run script to actually untar the files.
bash 'extract_module' do
  cwd "/d00"
  code <<-EOH
    
	tar xf "/tmp/#{src_filename_tomcat}" -C #{extract_path_tomcat}
    tar xf "/tmp/#{src_filename_java}" -C #{extract_path_java}
	cp -r "/tmp/#{src_filename_plms}" -C #{extract_path_plms}
	tar xf "/tmp/#{src_filename_settings}" -C #{extract_path_settings}
    tar xf "/tmp/#{src_filename_scripts}" -C #{extract_path_scripts} 
    EOH
  #not_if { ::File.exists?(extract_path) }
end