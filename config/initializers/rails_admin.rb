RailsAdmin.config do |config|
  config.parent_controller = '::ApplicationController'

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :admin
  end
  config.current_user_method(&:current_admin)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.model HotelPicture do
    edit do
      field :picture, :carrierwave
    end
  end

  config.model Hotel do
    edit do
      fields :name, :address, :phone_number, :wifi, :breakfast, :pool, :parking, :hotel_pictures
    end
    nested do
      field :hotel_pictures
    end
  end

  config.model Admin do
    edit do
      fields :email, :password, :password_confirmation
    end
  end

  config.actions do
    dashboard do
      only ["Admin","Hotel","User","Comment"]
    end
    index do
      only ["Admin","Hotel","User","Comment"]
    end
    new do
      only ["Admin","Hotel"]
    end
    bulk_delete
    show do
      only ["Admin","Hotel","User","Comment"]
    end
    edit do
      only ["Hotel"]
    end
    delete do
      except ["Admin"]
    end
    show_in_app do
      only ["Admin","Hotel","User","Comment"]
    end

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
