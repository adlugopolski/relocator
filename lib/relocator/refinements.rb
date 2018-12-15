module Relocator
  module Refinements
    refine String do
      def format(*args)
        Kernel.format(self, *args)
      end
    end
  end
end
