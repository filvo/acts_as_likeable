module ActsAsLikeable
  module Liker

    def self.included(base)
      base.class_eval do
        belongs_to :liker, :polymorphic => true
        has_many :likes, :as => :liker, :dependent => :delete_all do
          def likeables
            includes(:likeable).map(&:likeable)
          end
        end
      end
    end


    def liked model=nil
      like :likeable => model
    end

    def unliked model=nil
      unlike :likeable => model
    end

    def liked? likeable
      __likes__ = find_likes(:likeable_id => likeable.id, :likeable_type => likeable.class.name)
      __likes__.size > 0
    end


    # saving
    def like args = {}
      return nil if args[:likeable].nil?
      args[:likeable].like args.merge({:liker => self})
    end

    def unlike args = {}
      return false if args[:likeable].nil?
      args[:likeable].unlike args.merge({:liker => self})
    end

    def find_likes(extra_conditions = {})
      self.likes.where(extra_conditions)
    end

  end
end