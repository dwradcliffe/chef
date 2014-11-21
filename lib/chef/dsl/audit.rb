#
# Author:: Tyler Ball (<tball@getchef.com>)
# Copyright:: Copyright (c) 2014 Opscode, Inc.
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

require 'chef/audit/controls'

class Chef
  module DSL
    module Audit

      # Can encompass tests in a `control` block or `describe` block
      # Adds the controls group and block (containing controls to execute) to the runner's list of pending examples
      def controls(*args, &block)
        raise ::Chef::Exceptions::NoAuditsProvided unless block
        name = args[0]
        raise AuditNameMissing if name.nil? || name.empty?

        run_context.controls_groups << Chef::Audit::Controls.new(args, &block)
      end

    end
  end
end
