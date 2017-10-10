
def generate_alertmanager_flags
  config = ''
  node['prometheus']['alertmanager']['flags'].each do |flag_key, flag_value|
    config += "-#{flag_key}=#{flag_value} " if flag_value != ''
  end
  config
end
