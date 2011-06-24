class User
  include Mongoid::Document
  field :name, :type => String
  field :email, :type => String
  field :provider, :type => String
  field :uid, :type => String
  attr_accessible :provider, :uid, :name, :email

  embeds_many :expenses

  def self.create_with_omniauth(auth)
    begin
      create! do |user|
        user.provider = auth['provider']
        user.uid = auth['uid']

        if auth['extra']['user_hash']
          user.name = auth['extra']['user_hash']['name'] if auth['extra']['user_hash']['name'] # Facebook
          user.email = auth['extra']['user_hash']['email'] if auth['extra']['user_hash']['email'] # Facebook
        end
      end
    rescue Exception => ex
      raise Exception, "unable to create user account: #{ex.message}"
    end
  end

end
