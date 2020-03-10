class User < ActiveRecord::Base
    has_secure_password

    validates :email, uniqueness: { case_sensitive: false }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  before_save :format_email

  def format_email
    self.email.downcase!
    self.email.strip!
  end

  def authenticate_with_credentials(email, password)
    user = User.find_by_email(email.downcase.strip)

    if user.authenticate(password)
      return user
    else
      return nil
    end
  end
end
