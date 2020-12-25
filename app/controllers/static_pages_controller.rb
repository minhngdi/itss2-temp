class StaticPagesController < ApplicationController
    def home
        session[:select_id] = []
    end
end
