class PersonalMessagesController < ApplicationController
  before_action :find_conversation!

  def new
    if @conversation
      redirect_to hotel_path(:id => @conversation.hotel.id, :conversation_id => @conversation.id)
      return
    else
      @conversation ||= Conversation.create(author_id: current_user.id,
                                          receiver_id: @receiver.id, hotel_id: params[:hotel_id])
      @personal_message = current_user.personal_messages.build(:body => "Hello")
      @personal_message.conversation_id = @conversation.id
      @personal_message.save!
      #   @personal_message.conversation.touch
      #   NotificationBroadcastJob.perform(@personal_message, current_user.id)
      # end
      flash[:success] = "Your message was sent!"
      redirect_to hotel_path(:id => @conversation.hotel.id, :conversation_id => @conversation.id)
    end
  end

  def create
    @conversation ||= Conversation.create(author_id: current_user.id,
                                          receiver_id: @receiver.id, hotel_id: params[:id])
    @personal_message = current_user.personal_messages.build(personal_message_params)
    @personal_message.conversation_id = @conversation.id
    @personal_message.save!

    flash[:success] = "Your message was sent!"
    redirect_to hotel_path(:id => @conversation.hotel.id, :conversation_id => @conversation.id)
  end

  private

  def personal_message_params
    params.require(:personal_message).permit(:body)
  end

  def find_conversation!
    if params[:receiver_id]
      @receiver = User.find_by(id: params[:receiver_id])
      redirect_to(root_path) and return unless @receiver
      @conversation = Conversation.between(current_user.id, @receiver.id)[0]
    else
      @conversation = Conversation.find_by(id: params[:conversation_id])
      redirect_to(root_path) and return unless @conversation && @conversation.participates?(current_user)
    end
  end
end
