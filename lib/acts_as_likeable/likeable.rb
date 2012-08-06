module ActsAsLikeable
  module Likeable

    def self.included base
      base.class_eval do
        belongs_to :likeable, :polymorphic => true
        has_many   :likes, :as => :likeable, :dependent => :delete_all do
          def likers
            includes(:liker).map(&:liker)
          end
        end
      end
    end

    def default_conditions
      {
          :likeable_id => self.id,
          :likeable_type => self.class.base_class.name.to_s
      }
    end

    def liked_by liker
      like :liker => liker
    end

    def unliked_by liker
      self.unlike :liker => liker
    end

    def liked_by? liker
      return false if liker.nil?
      _likes_ = find_likes :liker_id => liker.id, :liker_type => liker.class.name
      _likes_.count > 0
    end


    def like args = {}
      return nil if args[:liker].nil?

      # find the like
      _likes_ = find_likes({
           :liker_id => args[:liker].id,
           :liker_type => args[:liker].class.name
      })

      if _likes_.count == 0
        _like_ = Like.new(
            :likeable => self,
            :liker => args[:liker]
        )
      else
        _like_ = _likes_.first
      end

      if _like_.save
        update_likes_counter
        _like_
      else
        nil
      end
    end

    def unlike args = {}
      return false if args[:liker].nil?
      _likes_ = find_likes({
           :liker_id => args[:liker].id,
           :liker_type => args[:liker].class.name
      })
      return true if _likes_.count == 0
      _likes_.each(&:destroy)
      update_likes_counter
      true
    end

    def update_likes_counter
      if self.respond_to?(:cached_likes_total=)
        self.class.where(:id => self.id).update_all(:cached_likes_total => self.likes.count)
      end
    end

    def find_likes extra_conditions = {}
      self.likes.where(extra_conditions)
    end


  end
end