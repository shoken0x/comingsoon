require 'pit'

class GConf
  config = Pit.get('gmail')  
  USERNAME=config['user']  #Gmailのアドレス
  PASSWORD=config['pass']  #Gmailのパスワード
  FROM="KitchHike <#{USERNAME}>"
  SUBJECT='Welcome to KitchHike!'
  BODY=<<EOS 
Thank you for registering with us!\n
KitchHike is still under construction.\n
We hope to deliver a service that will feed your curiosity & appetite, and give new spice to your life.\n
\n
We appreciate your patience in the meantime.\n
We'll let you know as soon as we're ready.\n
\n
KitchHike Team\n
http://kitchhike.com\n
EOS

end
