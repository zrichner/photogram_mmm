class Like < ApplicationRecord
  # Direct associations

  belongs_to :photo

  belongs_to :user

  # Indirect associations

  # Validations

end
