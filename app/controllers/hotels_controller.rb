class HotelsController < ApplicationController
  before_action :find_hotel, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    if params[:term]
      @hotels = Hotel.search_by_hotel_name(params[:term]).page(params[:page1]).per Settings.paginate.hotels
      @hotels2 = Hotel.search_by_hotel_address(params[:term]).page(params[:page2]).per Settings.paginate.hotels
      @keyword = params[:term]
    elsif params[:commit] == "フィルター"
      @hotels = Hotel.filter_by_service(params).page(params[:page]).per Settings.paginate.hotels
    else
      @hotels = Hotel.all.page(params[:page]).per Settings.paginate.hotels
    end
  end

  def new
    @hotel = Hotel.new
  end

  def create
    @hotel = current_user.hotels.build hotel_params
    if @hotel.save
      flash[:success] = t "create_hotel_success"
      redirect_to @hotel
    else
      render :new
    end
  end

  def show
    if @hotel.average("quality")
      @rate1 = @hotel.rates("quality").where(stars: 1).count
      @rate2 = @hotel.rates("quality").where(stars: 2).count
      @rate3 = @hotel.rates("quality").where(stars: 3).count
      @rate4 = @hotel.rates("quality").where(stars: 4).count
      @rate5 = @hotel.rates("quality").where(stars: 5).count
    else
      @rate1 = 0
      @rate2 = 0
      @rate3 = 0
      @rate4 = 0
      @rate5 = 0
    end
    if current_user && @hotel.average("quality")
      rate_avg = @hotel.average("quality").avg
      count = @hotel.rates("quality").count
      @hotel.update_attributes(rate_avg: rate_avg)
      @rated = @hotel.rates("quality").where(rater_id: current_user.id).present? ? 1 : 0
      if @rated == 1
        @oldstar = @hotel.rates("quality").where(rater_id: current_user.id).first.stars
      else
        @oldstar = 0
      end
      if @oldstar !=0
        if count == 1
          @oldrate = 0
        else
          @oldrate = (rate_avg * count - @oldstar) / (count - 1)
        end
      else
        @oldrate = @hotel.average("quality").avg
      end
    end
    @comments = @hotel.comments.order(:created_at).page(params[:page]).per(5)
    @pictures = @hotel.hotel_pictures
    if params[:conversation_id]
      @conversation = Conversation.find_by(id: params[:conversation_id])
      redirect_to root_path unless @conversation && @conversation.participates?(current_user)
      @personal_message = PersonalMessage.new
    end
  end

  def edit; end

  def update
    if @hotel.update_attributes hotel_params
      flash[:success] = t "update_hotel_success"
      redirect_to @hotel
    else
      render :edit
    end
  end

  def destroy
    @hotel.destroy
    flash[:success] = t "delete_hotel_success"
    redirect_to hotels_url
  end

  private

  def hotel_params
    params.require(:hotel).permit :title, :content, :hastags_list
  end

  def correct_user
    if current_user.admin?
      find_hotel
    else
      @hotel = current_user.hotels.find_by id: params[:id]
    end
    redirect_to hotel_hotels_url if @hotel.nil?
  end

  def find_hotel
    @hotel = Hotel.find_by id: params[:id]

    return if @hotel
    flash.now[:danger] = t "cant_find_hotel"
    redirect_to hotels_url
  end
end
