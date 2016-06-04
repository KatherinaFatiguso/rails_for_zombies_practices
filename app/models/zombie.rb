class Zombie < ActiveRecord::Base
  before_save :make_rotting
  has_one :brain, dependent: :destroy
  has_many :assignments
  has_many :roles, through: :assignments
  has_many :tweets
  after_save :decomp_change_notification, if: :decomp_changed?

  scope :rotting, ->{where(rotting: true)}
  scope :fresh, ->{where('age < 20')}
  scope :recent, ->{order('created_at desc').limit(3)}

  def make_rotting
    self.rotting = true if age > 20
  end

  def decomp_change_notification
    ZombieMailer.decomp_change(self).deliver_now
  end

end
