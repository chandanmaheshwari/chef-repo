#
# Cookbook Name:: sns_plms
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Create necessary directories

  directory "/home/ubuntu/plms" do
    mode 00775
    owner "ubuntu"
    group "ubuntu"
    action :create
    recursive true
  end

  directory "/home/ubuntu/properties" do
    mode 00775
    owner "ubuntu"
    group "ubuntu"
    action :create
    
  end
  
  directory "/home/ubuntu/scripts" do
    mode 00775
    owner "ubuntu"
    group "ubuntu"
    action :create
   
  end
  
  directory "/home/ubuntu/searchindex" do
    mode 00775
    owner "ubuntu"
    group "ubuntu"
    action :create
  end
  
  directory "/home/ubuntu/war" do
    mode 00775
    owner "ubuntu"
    group "ubuntu"
    action :create
  end
  

# Set variables  
  src_filename_java = "jdk-6u45-linux-x64.bin"
  src_filepath_java = "http://profcontent.ptc.com/jdk-6u45-linux-x64.bin"
  extract_path_java = "/home/ubuntu"

  src_filename_tomcat = "tomcat_u.tar"
  src_filepath_tomcat = "http://profcontent.ptc.com/tomcat_u.tar"
  extract_path_tomcat = "/home/ubuntu"

  src_filename_plms = "plms.war"
  src_filepath_plms = "http://profcontent.ptc.com/plms.war"
  extract_path_plms = "/home/ubuntu/war"

  src_filename_settings = "settings.tar"
  src_filepath_settings = "http://profcontent.ptc.com/settings.tar"
  extract_path_settings = "/home/ubuntu/properties"

  src_filename_scripts = "scripts_u.tar"
  src_filepath_scripts = "http://profcontent.ptc.com/scripts_u.tar"
  extract_path_scripts = "/home/ubuntu/scripts"

  redeploy_plms_script = "plms_redeploy.sh" 

# Copy the different files from profcontent
  remote_file "/tmp/#{src_filename_java}" do
    source "#{src_filepath_java}"
    owner 'ubuntu'
    group 'ubuntu'
    mode 00644
  end
  
  remote_file "/tmp/#{src_filename_tomcat}" do
    source "#{src_filepath_tomcat}"
    owner 'ubuntu'
    group 'ubuntu'
    mode 00644
  end
  


#Just for ec2 testing

 # remote_file "/tmp/#{src_filename_plms}" do
  #  source "#{src_filepath_plms}"
   # owner 'ubuntu'
    #group 'ubuntu'
    #mode 00644
  #end 
  
  remote_file "#{extract_path_plms}/#{src_filename_plms}" do
    source "#{src_filepath_plms}"
    owner 'ubuntu'
    group 'ubuntu'
    mode 00644
  end
  
  remote_file "/tmp/#{src_filename_settings}" do
    source "#{src_filepath_settings}"
    owner 'ubuntu'
    group 'ubuntu'
    mode 00644
  end 
  
  remote_file "/tmp/#{src_filename_scripts}" do
    source "#{src_filepath_scripts}"
    owner 'ubuntu'
    group 'ubuntu'
    mode 00644
  end 

  execute "install_java" do
    cwd "#{extract_path_java}"
    user "ubuntu"
    command "sh /tmp/#{src_filename_java}"
	environment 'JAVA_HOME' => "#{extract_path_java}/jdk1.6.0_45"
  end

# Run script to actually untar the files.
  bash 'extract_module' do
    
    user "ubuntu"
	code <<-EOH
    
	tar xf "/tmp/#{src_filename_tomcat}" -C #{extract_path_tomcat}
	tar xf "/tmp/#{src_filename_settings}" -C #{extract_path_settings}
    tar xf "/tmp/#{src_filename_scripts}" -C #{extract_path_scripts} 
    EOH
  #not_if { ::File.exists?(extract_path) } 
  end
 
  template "/etc/init.d/tomcat" do
    source "tomcat.erb"
    owner "ubuntu"
    mode "0755"  
  end
 
  execute "redeploy_plms" do
    cwd "#{extract_path_scripts}"
	user "ubuntu"
	#environment 'JAVA_HOME' => "#{extract_path_java}/jdk1.6.0_45"
	command "sh #{extract_path_scripts}/#{redeploy_plms_script}"
  end
  
  script "Start tomcat instance" do
    interpreter "bash"
    user "root"
    cwd "/tmp"
    code <<-EOH  
    /etc/init.d/tomcat start
    EOH
  end
  
  