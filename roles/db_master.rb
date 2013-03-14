{
  "name": "db_master",
  "description": "Master database server",
  "json_class": "Chef::Role",
  "default_attributes": {
  },
  "override_attributes": {
  },
  "chef_type": "role",
  "run_list": [
    "role[base]",
    "recipe[mysql::server]"
  ],
  "env_run_lists": {
    "prod": [
      "role[base]",
      "recipe[mysql::server]"
    ],
    "dev": [
      "role[base]",
      "recipe[mysql::server]"
    ]
  }
}
