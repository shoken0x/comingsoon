$LOAD_PATH.unshift File.dirname(__FILE__) + '/lib'
require "sinatra"

require "email.rb"

get '/' do
  @message = ''
  erb :index
end

post '/result' do
  if (Email.valid? (params[:email]) )
    Email.save ({:email                => params[:email],
                 :HTTP_ACCEPT_LANGUAGE => request.env["HTTP_ACCEPT_LANGUAGE"],
                 :HTTP_USER_AGENT      => request.env["HTTP_USER_AGENT"],
                 :HTTP_X_REAL_IP       => request.env["HTTP_X_REAL_IP"],
                 :REMOTE_ADDR          => request.env["REMOTE_ADDR"],
                 :create_at            => Time.now
    })
    Email.send params[:email]
    erb :result
  else
    @message = 'Not valid email'
    erb :index
  end
end
