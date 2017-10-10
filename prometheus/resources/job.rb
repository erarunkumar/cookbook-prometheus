#property :name,                String, name_property: true, required: true
#property :scrape_interval,     String
#property :scrape_timeout,      String
#property :target,              [Array, String]
#property :metrics_path,        String, default: '/metrics'
#property :config_file,         String, default: lazy { node['prometheus']['flags']['config.file'] }
#property :source, String, default: 'prometheus'


actions :create, :delete
attribute :name,   :kind_of => String 
attribute :scrape_interval, :kind_of => String  #  :regex => [ /^([a-z]|[A-Z]|[0-9]|_|-)+$/, /^\d+$/ ]
attribute :scrape_timeout,  :kind_of => String   #:regex => /^0?\d{3,4}$/
attribute :target,   	    :kind_of => [Array, String]          # :regex => [ /^([a-z]|[A-Z]|[0-9]|_|-)+$/, /^\d+$/ ]
attribute :metrics_path,    :kind_of => String, :default =>'/metrics'
attribute :config_file,     :kind_of => String ########:default => lazy { node['prometheus']['flags']['config.file'] }   #:regex => /^[a-zA-Z0-9]{64}$/
attribute :source, 	    :kind_of => String 


default_action :create
