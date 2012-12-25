# -*- coding: utf-8 -*-

require 'gconf'
require 'gmail'
require 'mongo'

class Email
  def self.save(data)
    db_name="comingsoon"
    coll_name = "users"

    db = Mongo::Connection.new.db(db_name)
    coll = db.collection(coll_name)
    
    result = coll.find({:email => data[:email]}).first
    if (!result)
      coll.insert(data)
    end

    db.connection.close
  end

  def self.send(_to)
    gmail = Gmail.new(GConf::USERNAME,GConf::PASSWORD)

    email = gmail.generate_message do
      to _to 
      subject GConf::SUBJECT
      body GConf::BODY
    end
    gmail.deliver(email)
    gmail.disconnect
  end

  def self.count
    db_name="comingsoon"
    coll_name = "users"

    db = Mongo::Connection.new.db(db_name)
    db.collection(coll_name).count()
  end

  def self.valid?(email)
    !!email.match(/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+$/)
  end
end
