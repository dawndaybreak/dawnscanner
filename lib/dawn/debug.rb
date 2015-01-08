module Codesake
  module Dawn
    module Debug

      def debug_me_and_return_true(msg)
        __debug_me_and_return(msg, true)
      end
      def debug_me_and_return_false(msg)
        __debug_me_and_return(msg, false)
      end
      def debug_me(msg)
        $logger.debug(msg) if @debug
      end

      def __debug_me_and_return(msg, status)
        $logger.debug(msg) if @debug
        return status
      end
    end
  end
end
