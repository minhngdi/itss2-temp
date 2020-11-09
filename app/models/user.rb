class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :authored_conversations, class_name: 'Conversation', foreign_key: 'author_id'
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'receiver_id'

  has_many :personal_messages, dependent: :destroy
  has_many :reports, dependent: :destroy
  acts_as_target
  has_many :comments, dependent: :destroy

  def online?
    !Redis.new.get("user_#{self.id}_online").nil?
  end
  mount_uploader :avatar, AvatarUploader
  ratyrate_rater
end
