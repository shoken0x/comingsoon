require 'pit'

class GConf
  config = Pit.get('gmail')  
  USERNAME=config['user']  #Gmailのアドレス
  PASSWORD=config['pass']  #Gmailのパスワード
  SUBJECT='Welcome KitchHike!!'
  BODY=<<EOS 
      KitchHike is coming soon...  Leave your email for early access.\n
      \n
      http://kitchhike.com
EOS

end
