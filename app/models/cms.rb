class Cms
  include ActiveModel::Model
  attr_accessor :version, :dir

  validates :version, presence: true
end
