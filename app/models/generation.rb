class Generation < ApplicationRecord
  belongs_to :machine
  validates	:generation_date, presence: true
  validates :generation_date, uniqueness: { scope: :machine_id }
  validates :generation_date, not_in_future: true
end
