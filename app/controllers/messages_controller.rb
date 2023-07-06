class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat_room

  def create
    @message = @chat_room.messages.new(message_params)
    @message.user = current_user

    if @message.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @chat_room }
      end
    else
      format.turbo_stream { render turbo_stream: turbo_stream.replace(@message, partial: "messages/form", locals: { message: @message }) }
      format.html { render "chat_rooms/show" }
    end
  end

  private

  def set_chat_room
    @chat_room = ChatRoom.find(params[:chat_room_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
