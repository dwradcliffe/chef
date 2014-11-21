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

require 'serverspec/helper'
require 'serverspec/matcher'
require 'serverspec/subject'
require 'rspec'

RSpec::Core::ExampleGroup.define_example_group_method :control

class Chef
  class Audit
    class Controls

      attr_reader :group

      def initialize(*args, &block)
        @group = RSpec::Core::ExampleGroup.__controls__(args, &block)
      end

    end
  end
end
