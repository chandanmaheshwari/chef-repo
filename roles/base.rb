{
  "name": "base",
  "description": "Base role applied 2 all nodes.",
  "json_class": "Chef::Role",
  "default_attributes": {
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
    "recipe[vim]"
  ],
  "env_run_lists": {
  }
}
