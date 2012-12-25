$LOAD_PATH.unshift File.dirname(__FILE__) + '/lib'
require "sinatra"

require "email.rb"
require "message.rb"

get '/' do
  @message = Message::WELCOME
  @form = true
  if request.user_agent.include?("Mobile")
    @mobile = true
  else
    @mobile = false
  end
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
    @form = false
    if request.user_agent.include?("Mobile")
      @mobile = true
    else
      @mobile = false
    end
    erb :index
  else
    @message = Message::NOTVALID
    @form = true
    if request.user_agent.include?("Mobile")
      @mobile = true
    else
      @mobile = false
    end
    erb :index
  end
end

get '/cnt' do
  Email.count.to_s
end
