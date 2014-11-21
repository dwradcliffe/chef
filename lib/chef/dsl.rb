
dsl_files = [
  'audit',
  'data_query',
  'include_attribute',
  'include_recipe',
  'platform_introspection',
  'recipe',
  'registry_helper'
]

dsl_files.each do |dsl_file|
  require "chef/dsl/#{dsl_file}"
end
