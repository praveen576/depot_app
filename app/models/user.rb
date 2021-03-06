class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  has_one :cart, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  # validates :name, presence: true, uniqueness: true
  # has_secure_password

  after_destroy :ensure_an_admin_remains
  
  private
  def ensure_an_admin_remains
    if User.count.zero?
      raise "Can't delete last user"
    end
  end
end
