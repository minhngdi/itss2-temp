class Hotel < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_hotel_name, against: [:name],
    using: {tsearch: {dictionary: 'english', prefix: true, any_word: true}}
  pg_search_scope :search_by_hotel_address, against: [:address],
    using: {tsearch: {dictionary: 'english', prefix: true, any_word: true}}
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :hotel_pictures
  has_many :conversations

  enum skin_color: {whites: 1, yellows: 2, blacks: 3}
  enum hair_color: {white: 1, yellow: 2, black: 3, moss_green: 4}

  accepts_nested_attributes_for :hotel_pictures
  attr_accessor :hotel_pictures_cache, :remove_hotel_pictures
  ratyrate_rateable "quality"
  has_many :rating_averages, class_name: :RatingCache, foreign_key: :cacheable_id do
    def with_dimension(dimension)
      where dimension: dimension
    end
  end


  def self.filter_by_service(params)
    services = params.keys & ["wifi", "pool", "breakfast", "parking"]
    hotels = Hotel.all
    services.each do |service|
      hotels = hotels.where(service, true)
    end
    if params[:gender] == "true"
      hotels = hotels.where(gender: true)
    elsif params[:gender] == "false"
      hotels = hotels.where(gender: false)
    end
    
    if (params.include? "star") && (params[:star].to_i >=1) && (params[:star].to_i <=5)
      hotels.each do |hotel|
        if hotel.average("quality")
          rate_avg = hotel.average("quality").avg
          hotel.update_attributes(rate_avg: rate_avg)
        end
      end
      hotels = hotels.where('rate_avg >= ?', params[:star])
    end

    if params[:event] == "結婚式"
      hotels = hotels.where(wifi: true)
    elsif params[:event] == "パーティー"
      hotels = hotels.where(pool: true)
    elsif params[:event] == "デート"
      hotels = hotels.where(parking: true)
    elsif params[:event] == "旅行"
      hotels = hotels.where(breakfast: true)
    end
    
    if params[:gender] == "男"
      hotels = hotels.where(gender: true)
    elsif params[:gender] == "女"
      hotels = hotels.where(gender: false)
    end

    if params[:skin_color] == "whites" || params[:skin_color] == "白"
      hotels = hotels.where(skin_color: "whites")
    elsif params[:skin_color] == "yellows" || params[:skin_color] == "黄"
      hotels = hotels.where(skin_color: "yellows")
    elsif params[:skin_color] == "blacks" || params[:skin_color] == "黒"
      hotels = hotels.where(skin_color: "blacks")
    end

    if params[:hair_color] == "white" || params[:hair_color] == "白"
      hotels = hotels.where(hair_color: "white")
    elsif params[:hair_color] == "yellow" || params[:hair_color] == "黄"
      hotels = hotels.where(hair_color: "yellow")
    elsif params[:hair_color] == "black" || params[:hair_color] == "黒"
      hotels = hotels.where(hair_color: "black")
    elsif params[:hair_color] == "moss_green" || params[:hair_color] == "モスグリーン"
      hotels = hotels.where(hair_color: "moss_green")
    end

    return hotels
  end
end
