require 'rails/generators/migration'

module ActsAsLikeable
  class MigrationGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    desc "Generates migration for acts_as_likeable (likes table)"

    def self.orm
      Rails::Generators.options[:rails][:orm]
    end

    def self.source_root
      File.join(File.dirname(__FILE__), 'templates', (orm.to_s unless orm.class.eql?(String)) )
    end

    def self.orm_has_migration?
      [:active_record].include? orm
    end

    def self.next_migration_number(path)
      Time.now.strftime("%Y%m%d%H%M%S")
    end

    def create_migration_file
      if self.class.orm_has_migration?
        migration_template 'migration.rb', 'db/migrate/acts_as_likeable_migration'
        copy_file 'like.rb', 'app/models/like.rb'
      end
    end
  end
end