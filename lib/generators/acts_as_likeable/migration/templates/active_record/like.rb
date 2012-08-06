class Like < ::ActiveRecord::Base
  attr_accessible :likeable_id, :likeable_type,
                  :liker_id, :liker_type,
                  :likeable, :liker

  belongs_to :likeable, :polymorphic => true
  belongs_to :liker, :polymorphic => true

  validates_presence_of :likeable_id
  validates_presence_of :liker_id
end