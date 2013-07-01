class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  attr_accessible :email, :password, :password_confirmation, :remember_me

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.find_by_email(data["email"])

    unless user
      user = User.create(email: data["email"], password: Devise.friendly_token[0,20])
    end
    user
  end

  # Finds associated notice--ActiveRecord::Base.has_one does not work with Ohm
  def notice
    Notice.find(user_id: id).first || Notice.new(user_id: self)
  end

  # Default representation of user is the email address
  def to_s
    email
  end
end
