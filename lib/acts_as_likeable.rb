require 'active_record'
require 'active_support/inflector'

$LOAD_PATH.unshift(File.dirname(__FILE__))

module ActsAsLikeable

  if defined?(ActiveRecord::Base)
    require 'acts_as_likeable/extenders/likeable'
    require 'acts_as_likeable/extenders/liker'
    ActiveRecord::Base.extend ActsAsLikeable::Extenders::Likeable
    ActiveRecord::Base.extend ActsAsLikeable::Extenders::Liker
  end

end
