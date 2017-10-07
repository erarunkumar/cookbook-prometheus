# Load the promethues cookbook into your wrapper so you have access to the LWRP and attributes

include_recipe "prometheus::use_lwrp"

# Assumes service_name is an attribute of each node
client_servers.each do |server|
	prometheus_job server['service_name'] do
  	  scrape_interval   "server['scrape_interval']"
	  target            "server['target']#{node['prometheus']['flags']['web.listen-address']}"
	  metrics_path      "#{node['prometheus']['flags']['web.telemetry-path']}"
	end
end

# Now run the default recipe that does all the work configuring and deploying prometheus
include_recipe "prometheus::default"
