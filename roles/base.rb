{
  "name": "base",
  "description": "Base role applied 2 all nodes.",
  "json_class": "Chef::Role",
  "default_attributes": {
    "java": {
     "oracle": {
       "accept_oracle_download_terms": true
     }
   }
  },
  "override_attributes": {
    "authorization": {
      "sudo": {
        "passwordless": true,
        "users": [
          "ubuntu",
          "vagrant"
        ]
      }
    }
  },
  "chef_type": "role",
  "run_list": [
    "recipe[users::sysadmins]",
    "recipe[sudo]",
    "recipe[apt]",
    "recipe[git]",
    "recipe[build-essential]",
    "recipe[vim]",
	"recipe[java]"
  ],
  "env_run_lists": {
  }
}
