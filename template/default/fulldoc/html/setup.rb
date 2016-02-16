
def generate_version_list
  @list_title = 'Version List'
  @list_type = 'version'

  asset('version_list.html', erb(:full_list))
end
