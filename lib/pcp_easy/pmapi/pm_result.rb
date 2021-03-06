require 'ffi'

require 'pcp_easy/pmapi/timeval'
require 'pcp_easy/pmapi/pm_value_set'

module PCPEasy
  class PMAPI
    class PmResult < FFI::Struct
      layout :timestamp, Timeval,
             :numpmid, :int,
             :vset, :pointer
             # pointer to start of PmValueSet

      def vset
        numpmid.times.collect do |n|
          PmValueSet.new((start_of_vset + FFI::Pointer.size * n).get_pointer(0))
        end
      end

      def numpmid
        self[:numpmid]
      end

      def timestamp
        self[:timestamp]
      end

      private

      def start_of_vset
        pointer + (self.size - FFI::Pointer.size)
      end

    end
  end
end