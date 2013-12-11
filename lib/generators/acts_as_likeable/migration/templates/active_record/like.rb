class Like < ::ActiveRecord::Base
  
  # relationship
  belongs_to :likeable, polymorphic: true, touch: true
  belongs_to :liker, polymorphic: true, touch: true

  # validations
  validates_presence_of :likeable_id
  validates_presence_of :liker_id
  
end