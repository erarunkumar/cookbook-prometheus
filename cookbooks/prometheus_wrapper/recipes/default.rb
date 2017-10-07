# Load the promethues cookbook into your wrapper so you have access to the LWRP and attributes

include_recipe "prometheus::use_lwrp"

# Add a rule filename under `rule_files` in prometheus.yml.erb

# Example of using search to populate prometheus.yaml jobs using the prometheus_job LWRP
# Finds all the instances that are in the current environment and are taged with "node_exporter"
# Assumes that the service instances were tagged in their own recipes.
client_servers = search(:node, "environment:#{node.chef_environment} AND tags:node_exporter")

# Assumes service_name is an attribute of each node
client_servers.each do |server|
	prometheus_job server.service_name do
  	  scrape_interval   '15s'
	  target            "#{server.fqdn}#{node['prometheus']['flags']['web.listen-address']}"
	  metrics_path      "#{node['prometheus']['flags']['web.telemetry-path']}"
	end
end

# Now run the default recipe that does all the work configuring and deploying prometheus
include_recipe "prometheus::default"
