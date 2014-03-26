## Seppku Recipe

file '/etc/cron.d/go_reboot' do
  action :delete
end

directory '/opt/lw1' do
  action :delete
  recursive true
end
