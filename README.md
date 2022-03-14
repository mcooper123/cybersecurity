## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![Network Diagram](Diagrams/network_diagram_with_ELK_server.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the playbook file may be used to install only certain pieces of it, such as Filebeat.

- [Filebeat playbook](ansible/filebeat-playbook.yml)

This document contains the following details:
- Description of the Topologu
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the Damn Vulnerable Web Application.

Load balancing ensures that the application will be highly stable, in addition to restricting access to the network. 

- Load balancers protect the availability of your web servers by preventing bottlenecks. They achieve this by systematically distributing the incoming traffic over all available services as defined by their rules for distributing packet data. This network redundancy means that if one of your servers is down, need to perform maintenance or you need to upgrade your servers, the availability of your website isn't compromised.
- The main advantage of a jump box is that it provides a secure perimeter around IT resources. Providing admins with ease of access to these resources once they've connected to the jump box, they can easily maintain the entire network (or portion of the network that the jump box provides access to) from one machine using scripts (such as ansible) to update/upgrade/deploy/remove/uninstall/start/stop software and services on the network.
  More recently, security professionals have been moving away from jump boxes (servers) as they provide a single point of failure - that is, if an attacker can access the jump box, then they can easily move about within all of the resources connected to that jump box. This flaw was highlighted in the data breach experienced by the U.S Office of Personnel Management in 2015 when an attacker gained access to their jump server and subsequently had access to their entire network.
 
Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the logs and system traffic.
- Using Filebeat, you can monitor log files or defined locations, it will then collect log events and forward this data to either Elasticsearch or Logstash for indexing.
- Metricbeat allows to collect a list of metrics (a metricset) for a specific service. The exact data collect will depend upon what type of service Metricbeat is monitoring. For example, when Metricbeat is monitoring a webserver, it will return data on unique hits, country source, ip address, source OS etc.

The configuration details of each machine may be found below.

|  Name        | Function   | IP Address  | Operating System  |
|--------------|------------|-------------|-------------------|
| Jump Box     |  Gateway   | 10.0.0.4 (52.189.222.222)    |  Linux            |
| Web 1        | Web Server | 10.0.0.5    |  Linux            |
| Web 2        | Web Server | 10.0.0.6    |  Linux            |
| Web 3        | Web Server | 10.0.0.7    |  Linux            |
| ELK-Server   | ELK-Server | 10.1.0.4 (20.37.6.102)   |  Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the jump box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- 180.150.xxx.xx

Machines within the network can only be accessed by the jump box.
- The ELK server is accessable by any machine within the VNet and from one external computer with an ip address of 180.150.xxx.xx

A summary of the access policies in place can be found in the table below.

|  **Name**  | **Publicly Accessible** |       **Allowed IP Addresses**      |
|:----------:|:-----------------------:|:-----------------------------------:|
| Jump Box   | Yes                     | 180.150.xxx.xx and all VNet IP addresses                     |
| Web 1      | No                      |  All VNet IP addresses               |
| Web 2      | No                      |  All VNet IP addresses                |
| Web 3      | No                      |  All VNet IP addresses               |
| ELK Server | Yes                     | 180.150.xxx.xx and all VNet IP addresses |
### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because using ansible to configure the web servers means that you can configure 1 or 100 machines with the same amount of work. Additionally, once you have your ansible playbook correctly configured, then all future deployments using that playbook will be exactly the same and error free.

The playbook implements the following tasks:
- Increase the max mmap limit (set vm.max_map_count to 262144 in sysctl) to ensure that running Elasticsearch doesn't result in out of memory exceptions as the default system limits will most likely be too low.
- Download and install docker.io
- Download and install python3
- Download and install docker python package
- Download and launch a docker elk container
- Set docker service to always start on boot

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.
 
![docker ps output](Ansible/docker_ps_output.png)

 ### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- 10.0.0.5
- 10.0.0.6
- 10.0.0.7

We have installed the following Beats on these machines:
- Metricbeat
- Filebeat

These Beats allow us to collect the following information from each machine:
- Filebeat forwards all logs in /var/log (Linux) for each machine to logstash, then onto Kibana or directly to Kibana. Using Kibana, you can then view various dashboards in Kibana based on these logs, such as access logs or user logs.
- Metricbeat captures specific metricsets, reported via Kibana. These metrics can include information about activity on you web servers, such as source IP address, source geo location, OS type, browser, html response codes etc.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Make sure that `/etc/ansible/hosts` file is updated to correctly reflect your VNet configuration. Search for `[webservers],`and uncomment that line, then list the private IP addresses for your web servers under it. Create a new group `[elk]` and list your ELK server under that. Make sure you put `ansible_python_interpreter=/usr/bin/python3` after each ip address to prevent python errors.![ansible hosts](Ansible/ansible_hosts.PNG)
- Copy the configuration files for [filebeat](Ansible/filebeat-config.yml) and [metricbeat](Ansible/metricbeat-config.yml) to /etc/ansible/files/ on the control node. You might need to create this directory first.
- Update each configuration file to include the correct IP address and port for your ELK server in the `Elasticsearch output` (eg. 10.1.0.4:9200) section for both files and the `Kibana` section (eg. 10.1.0.4:5601) for the metricbeat configuration.

![filebeat config edit](Ansible/filebeat_config_edit.PNG)
![metricbeat config elasticsearch edit](Ansible/metricbeat_config_edit_elasticsearch.PNG)
![metricbeat config kibana edit](Ansible/metricbeat_config_edit_kibana.PNG)
- Run the playbooks for [filebeat](Ansible/filebeat-playbook.yml) and [metricbeat](Ansible/metricbeat-playbook.yml) respectively, and navigate to your ELK server (eg. http://20.37.6.102:5601) to check that the installation worked as expected. The playbooks to install metricbeat and filebeat know which machines to install on based on the configuration (webservers) of the hosts file in /etc/ansible/ and the host setting in the playbook to match. The ELK server belongs to the `elk` group, not `webservers`, so metricbeat and filebeat won't be installed on it using these playbooks. 
- HTTP was used as opposed to HTTPS as this was a class project with no budget for installing a TLS certificate to provide HTTPS. I strongly recommend always using HTTPS instead of HTTP in commercial networks for the added security it provides.
  
### Kibana investigation
- Once everything was installed, I intentionally launched failed attempts to hack into my web server through use of a loop command `for i in {1..1000}; do ssh sysadmin@10.0.0.5; done` and `while true; do for i in {5..7}; do ssh sysadmin@10.0.0.$i; done; done` from my jump box server. The reason this failed is because the valid ssh key was generated within the ansible container on the jump box, not directly in the jump box itself. Inspection of the logs data revealed the long list of failed ssh login attempts. 
- Next I accessed one of my web servers and installed the apt `stress`. Upon running the command `sudo stress --cpu 1`, under metrics, I could see the cpu usage on that web server go to 100%. In real life, this could be an indicator of a potential breach attempt.
- To further test the metrics in Kibana, I looped a wget command for approximately 1 minute across all web servers via `while true; do for i in {5..7}; do wget -O /dev/null 10.0.0.$i; done; done`. Upon inspecting the metrics for each VM, I noticed an unusually large spike in incoming and outgoing data. This is another indicator of a potential attempt to breach.
