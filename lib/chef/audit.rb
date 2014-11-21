#
# Author:: Claire McQuin (<claire@getchef.com>)
# Copyright:: Copyright (c) 2014 Chef Software, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'rspec'
require 'rspec/its'
require 'specinfra'

require 'chef/audit/audit_event_proxy'
require 'chef/audit/rspec_formatter'

class Chef
  class Audit

    def self.configuration
      RSpec.configuration
    end

    def self.world
      RSpec.world
    end

    if defined?(RSpec)
      RSpec::Core::ExampleGroup.define_example_group_method :__controls__

      # Explicitly disables :should syntax.
      # :should is deprecated in RSpec 3.
      # This can be removed once RSpec no longer supports :should.
      RSpec.configure do |config|
        config.expect_with :rspec do |c|
          c.syntax = :expect
        end
      end

      # We're setting the output stream, but that will only be used for error situations
      # Our formatter forwards events to the Chef event message bus
      # TODO do some testing to see if these output to a log file - we probably need
      # to register these before any formatters are added.
      configuration.output_stream = Chef::Config[:log_location]
      configuration.error_stream = Chef::Config[:log_location]

      # Adds the formatters used for reporting and displaying audit information
      configuration.add_formatter(Chef::Audit::RspecFormatter)
      configuration.add_formatter(Chef::Audit::AuditEventProxy)
    end

    if defined?(Specinfra)
      # TODO: May need to adjust based on platform. There is a PowerShell backend
      # that we may want to use for Windows. Possibly we will have to roll our own.
      Specinfra.configuration.backend = :exec
    end

  end
end
