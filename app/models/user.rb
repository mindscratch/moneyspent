class User
  include Mongoid::Document
  field :name, :type => String
  field :email, :type => String
  embeds_many :authentications


  end
end
