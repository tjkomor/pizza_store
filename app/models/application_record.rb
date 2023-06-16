class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def downcase_name
    self.name = name.downcase
  end
end
