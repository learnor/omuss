class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    def display_name
      self.email.split("@").first
    end
    has_many :groups
    has_many :admins
    has_many :admin_groups, :through => :admins, :source => :group
    def is_admin_of?(group)
      admin_groups.include?(group)
    end

    def admin!(group)
      admin_groups << group
    end

    def unadmin!(group)
      admin_groups.delete(group)
    end

end
