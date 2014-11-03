include_recipe "swap_device::disable"

bash "create swap file #{node['custom_swap']['swapfile_name']}" do
  user 'root'
  code <<-EOC
    dd if=/dev/zero of=#{node['custom_swap']['swapfile_name']} bs=1M count=#{node['custom_swap']['swapfile_size_mb']}
    mkswap #{node['custom_swap']['swapfile_name']}
    chown root:root #{node['custom_swap']['swapfile_name']}
    chmod 0600 #{node['custom_swap']['swapfile_name']}
  EOC
  creates node['custom_swap']['swapfile_name']
end

mount 'swap' do
  action :enable
  device node['custom_swap']['swapfile_name']
  fstype 'swap'
end

bash 'activate all swap devices' do
  user 'root'
  code 'swapon -a'
end