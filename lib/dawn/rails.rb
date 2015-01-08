require 'dawn/engine'
module Dawn
  class Rails
    include Dawn::Engine


    def initialize(options={})
      super(options)
    end
  end
end
