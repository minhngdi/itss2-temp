class Report < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  acts_as_notifiable :users,
    # Notification targets as :targets is a necessary option
    # Set to notify to author and users commented to the article, except comment owner self
    targets: ->(report, key) {
      ([User.first]).uniq
    },
    tracked: true,
    # Path to move when the notification is opened by the target user
    # This is an optional configuration since activity_notification uses polymorphic_path as default
    notifiable_path: :custom_notifiable_path

  def custom_notifiable_path
    reports_path
  end
end
