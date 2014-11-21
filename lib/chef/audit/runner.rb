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

class Chef
  class Audit
    class Runner

      attr_reader :run_context
      private :run_context

      def initialize(run_context)
        @run_context = run_context
      end

      def run
        require 'chef/audit'

        setup
        # The first parameter passed to RSpec::Core::Runner.new
        # is an instance of RSpec::Core::ConfigurationOptions, which is
        # responsible for processing command line options passed through rspec.
        # This then gets merged with the configuration. We'll just communicate
        # directly with the Configuration here.
        runner = RSpec::Core::Runner.new(nil, Audit.configuration, Audit.world)
        runner.run_specs(Audit.world.ordered_example_groups)
      end

      private
      def setup
        Chef::Audit::AuditEventProxy.events = run_context.events

        # Register example groups with the world.
        # Will be useful if we later decide to apply our own run ordering, or
        # use example group filters.
        run_context.controls_groups.each { |controls| Audit.world.register(controls.group) }
      end
    end
  end
end
