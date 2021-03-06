require 'objspace'

module Datadog
  module Core
    module Environment
      # Retrieves garbage collection statistics
      # DEV: Currently only used for testing.
      module ObjectSpace
        module_function

        def estimate_bytesize(object)
          return 0 unless ::ObjectSpace.respond_to?(:memsize_of)

          # Rough calculation of bytesize; not very accurate.
          object.instance_variables.inject(::ObjectSpace.memsize_of(object)) do |sum, var|
            sum + ::ObjectSpace.memsize_of(object.instance_variable_get(var))
          end
        end
      end
    end
  end
end
