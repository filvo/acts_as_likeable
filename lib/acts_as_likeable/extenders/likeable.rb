module ActsAsLikeable
  module Extenders

    module Likeable

      def likeable?
        false
      end

      def acts_as_likeable
        require 'acts_as_likeable/likeable'
        include ActsAsLikeable::Likeable

        class_eval do
          def self.likeable?
            true
          end
        end
      end

    end

  end
end