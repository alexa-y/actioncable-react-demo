class Message < ApplicationRecord
  after_commit on: [:create] do
    MessagesChannel.broadcast_to 'messages', method: 'message', message: self
  end
end
