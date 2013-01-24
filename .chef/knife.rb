current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "cmaheshwari"
client_key               "#{current_dir}/cmaheshwari.pem"
validation_client_name   "ptc11-validator"
validation_key           "#{current_dir}/ptc11-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/ptc11"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
#cookbook_path            ["#{current_dir}/../cookbooks"]
cookbook_path            ["#{ENV['HOME']}/chef-repo/cookbooks"]
