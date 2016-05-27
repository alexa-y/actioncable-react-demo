class MessagesController < ApplicationController

  def index
    @messages = Message.all.order(created_at: :desc).limit(50)
    render json: @messages
  end
end
