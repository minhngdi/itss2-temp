class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :reports, dependent: :destroy

  validates :body, presence: true
  validates :user_id, presence: true


end
