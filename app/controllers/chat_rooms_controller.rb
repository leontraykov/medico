class ChatRoomsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @chat_rooms = ChatRoom.all
  end

  def new
    @chat_room = ChatRoom.new
    @users = User.where.not(id: current_user.id)
  end

  def create
    users = User.all
    @chat_room = ChatRoom.new(chat_room_params)
  
    if @chat_room.save
      @chat_room.users << current_user
      redirect_to @chat_room, notice: 'Chat room was successfully created.'
    else
      render :new
    end
  end
  
  def show
    @chat_room = ChatRoom.find(params[:id])
    @message = Message.new
    @messages = @chat_room.messages.order(created_at: :desc)
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:name, user_ids: [])
  end
end
