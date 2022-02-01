class Horon < ApplicationRecord

  #validation
  validates :name, presence: true
  validates :work_space_id, presence: true
  validates :last_update_user_id, presence: true

  #Assosiation
  belongs_to :work_space

  #method
  def children
    children = Horon.where(parent_id: self.id)
  end

  def parallel
    parallel = Horon.where(parent_id: self.parent_id)
  end
end
