$LOAD_PATH.unshift File.dirname(__FILE__) + '/lib'
require "sinatra"

require "email.rb"

get '/' do
  erb :index
end

post '/result' do
  Email.save ({:email => params[:email]})
  Email.send params[:email]
  erb :result
end
