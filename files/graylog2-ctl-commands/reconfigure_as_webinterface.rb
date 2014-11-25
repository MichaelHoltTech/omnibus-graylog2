add_command 'reconfigure-as-webinterface', 'Run Graylog2 web interface and MongoDB on this node', 1 do |cmd_name|
  require 'fileutils'
  require 'json'

  if true
    existing_services ||= Hash.new
    if File.exists?("/etc/graylog2/graylog2-services.json")
      existing_services = JSON.parse(File.read("/etc/graylog2/graylog2-services.json"))
    else
      FileUtils.mkdir("/etc/graylog2")
      existing_services['nginx']           = Hash.new
      existing_services['mongodb']         = Hash.new
      existing_services['elasticsearch']   = Hash.new
      existing_services['graylog2_server'] = Hash.new
      existing_services['graylog2_web']    = Hash.new
    end

    existing_services['nginx']['enabled']           = true
    existing_services['mongodb']['enabled']         = true
    existing_services['elasticsearch']['enabled']   = false
    existing_services['graylog2_server']['enabled'] = false
    existing_services['graylog2_web']['enabled']    = true

    File.open("/etc/graylog2/graylog2-services.json","w") do |services|
      services.write(JSON.pretty_generate(existing_services))
    end

    reconfigure
  else
    puts "Usage: #{cmd_name}"
  end
end