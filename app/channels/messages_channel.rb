# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stop_all_streams
    stream_for 'messages'
    MessagesChannel.broadcast_to 'messages', method: 'user_status', user: current_user, message: 'You are now online'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    sent_message(data) if data['method'] == 'sent_message'
  end

  def sent_message(data)
    Message.create user: current_user, body: data['message']
  end
end
