class Contact < ActiveRecord::Base
  # Contact form validations
  validates :name, presence: true
  validates :email, presence: true
  validates :comment, presence: true
end