class ComparesController < ApplicationController

  def index
    if params[:compares_ids] && params[:compares_ids].length == 2
      id2 = params[:compares_ids][-1].to_i
      id1 = params[:compares_ids][-2].to_i
      @hotels1 = Hotel.find_by(id: id1)
      @hotels2 = Hotel.find_by(id: id2)
    else
      @no_hope = true
    end
  end

  def show
    @hotel = Hotel.find_by id: params[:id]

    if params[:search]
      @hotels = Hotel.search_by_hotel_name(params[:search]).order(id: :asc).page(params[:page]).per Settings.paginate.hotels
      @keyword = params[:search]
    else
      @hotels = Hotel.all.order(id: :asc).page(params[:page]).per Settings.paginate.hotels
    end
  end
end
