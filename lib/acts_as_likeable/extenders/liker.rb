module ActsAsLikeable
  module Extenders

    module Liker

      def liker?
        false
      end

      def acts_as_liker(*args)
        require 'acts_as_likeable/liker'
        include ActsAsLikeable::Liker

        class_eval do
          def self.liker?
            true
          end
        end

      end

    end
  end
end