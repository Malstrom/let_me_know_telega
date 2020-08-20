# To make this script work you should:
# gem install telegram-bot-ruby


require 'telegram/bot'
require 'net/http'
require 'json'

# custom api create to simple handle iarena calls
load 'iarena_api.rb'

telegram_token = '1329385599:AAF2fG7pimqohw12-_gTAZ59qLvYB6cRu0w'
iarena_token   = '1329385599:AAF2fG7pimqohw12-_gTAZ59qLvYB6cRu0w'
# example of already exiting object



# obtain contact phone number of telegram user to match with iArena account.
def iarena_user_matching(phone_number)
  response = Iarena_api.find_by_phone_number(phone_number)
end

Telegram::Bot::Client.run(telegram_token) do |bot|
  bot.listen do |message|
      text = "Give me your phone"
      kb = Telegram::Bot::Types::KeyboardButton.new(text: text, request_contact: true)
      markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: kb)
      if sender = message.contact
        response = iarena_user_matching(message.contact.phone_number)
        bot.api.send_message(chat_id: message.chat.id, text: "Hi, #{response }")
      end
  end
end
