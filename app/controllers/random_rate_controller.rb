class RandomRateController < ApplicationController
  def index
    if params[:event]
      if params[:event] == "結婚式"
        @hotels = Hotel.filter_by_service(params)
      elsif params[:event] == "パーティー"
        @hotels = Hotel.filter_by_service(params)
      elsif params[:event] == "デート"
        @hotels = Hotel.filter_by_service(params)
      elsif params[:event] == "旅行"
        @hotels = Hotel.filter_by_service(params)
      end
    else
      @hotels = Hotel.all
    end

    if params[:commit] == "選ぶ"
      if params[:rate_id]
        @update_hotel = Hotel.find_by(id: params[:rate_id].to_i)
        @update_hotel.update_attribute :choose_people, @update_hotel.choose_people + 1
        redirect_to hotel_path(@update_hotel.id)
      end
    end

    ids = []
    @hotels.each do |i|
      ids = ids.push(i.id) 
    end

    if params[:rate_id]
      @hotel1 = Hotel.find_by(id: params[:rate_id].to_i)
    else
      @hotel1 = @hotels.sample
    end

    if session[:select_id].empty?
      session[:select_id] = session[:select_id].push(@hotel1.id)
    end

    if params[:select_id]
      a = params[:select_id].split(" ")
      session[:select_id] = session[:select_id].push(a[0].to_i)
      session[:select_id] = session[:select_id].push(a[1].to_i)
    end
    
    able_ids = ids.select{ |i| session[:select_id].include?(i) == false }
    if able_ids.empty?
      @hotel2 = @hotel1
    else
      @hotel2 = Hotel.find_by(id: able_ids.sample)
    end
    puts "cdcdcd----", able_ids
  end
end
