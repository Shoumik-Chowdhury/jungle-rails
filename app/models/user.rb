class User < ActiveRecord::Base
  has_secure_password

  def self.authenticate_with_credentials email, password
    user = User.find_by_email(email.downcase.strip)
    if user && user.authenticate(password)
      return user
    end
    nil
  end

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 4 }
end
