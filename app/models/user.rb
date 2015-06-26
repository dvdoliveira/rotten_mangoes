class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews
  after_destroy :delete_notification 

  validates :email,
    presence: true

  validates :firstname,
    presence: true

  validates :lastname,
    presence: true

  validates :password,
    length: { in: 6..20 }, on: :create

  def full_name
    "#{firstname} #{lastname}"
  end
  
  def delete_notification
    UserMailer.delete_notification(self).deliver
  end
  
    
    

end
