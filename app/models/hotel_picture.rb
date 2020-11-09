class HotelPicture < ApplicationRecord
  mount_uploader :picture, PictureUploader
  belongs_to :hotel
end
