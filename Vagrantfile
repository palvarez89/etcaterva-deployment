# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/trusty64"

  config.vm.define 'echaloasuerte1' do |machine|
    machine.vm.hostname = 'echaloasuerte1'
    machine.vm.network "private_network", ip: "192.168.77.22"

    machine.vm.provision :ansible do |ansible|
      ansible.playbook = "site.yml"
      ansible.sudo = true
      ansible.verbose = 'vvvv'

      ansible.extra_vars = {
        ansible_ssh_user: 'vagrant',
        ES_FQDN: "192.168.77.22.xip.io",
        mysqldb_admin_user: "root",
        mysqldb_admin_password: "rootpass",
        mongodb_admin_user: "root",
        mongodb_admin_password: "rootpass",
        echaloasuerte_gmail_password: "gmailpass",
      }

      ansible.groups = {
        "MONGO_DATABASES" => ["echaloasuerte1"],
        "ECHALOASUERTE" => ["echaloasuerte1"],
      }

      # Disable default limit (required with Vagrant 1.5+)
      ansible.limit = 'all'

    end
  end

end