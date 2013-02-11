$LOAD_PATH.unshift File.dirname(__FILE__) + '/lib'
require "sinatra"

require "email.rb"
require "message.rb"

before do
  @isForm = true
  @isMobile = request.user_agent.include?("Mobile")
end

get '/' do
  @message = Message::WELCOME
  erb :index
end

post '/' do
  if (Email.valid? (params[:email]) )
    Email.save ({:email                => params[:email],
                 :HTTP_ACCEPT_LANGUAGE => request.env["HTTP_ACCEPT_LANGUAGE"],
                 :HTTP_USER_AGENT      => request.env["HTTP_USER_AGENT"],
                 :HTTP_X_REAL_IP       => request.env["HTTP_X_REAL_IP"],
                 :REMOTE_ADDR          => request.env["REMOTE_ADDR"],
                 :create_at            => Time.now
    })
    Email.send params[:email]
    @message = Message::THANKYOU
    @isForm = false
    erb :index
  else
    @message = Message::NOTVALID
    erb :index
  end
end

get '/cnt' do
  Email.count.to_s
end

get '/privacy_policy' do
  'KitchHike privacy_policy' 
end

get '/terms_of_use' do
  'KitchHike terms_of_use' 
end
