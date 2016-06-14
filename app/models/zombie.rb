class Zombie < ActiveRecord::Base
  before_save :make_rotting
  has_one :brain, dependent: :destroy
  has_many :assignments
  has_many :roles, through: :assignments
  has_many :tweets
  after_save :decomp_change_notification, if: :decomp_changed?

  validates :name, presence: true
  
  scope :rotting, ->{where(rotting: true)}
  scope :fresh, ->{where('age < 20')}
  scope :recent, ->{order('created_at desc').limit(3)}

  def make_rotting
    if self.age.present?
      self.rotting = true if age > 20
    end
  end

  def decomp_change_notification
    ZombieMailer.decomp_change(self).deliver_now
  end

  # This will check if we have specified what we want in json it will that format as 'options',
  # otherwise if there is no pre-arranged json specification, it will use this hash.
  # see where to use it in the show.html.erb page
  def as_json(options = nil)
    super(options ||
      {include: [brain: { only: [:flavour] }], except: [:id, :created_at, :updated_at]})
  end
  # The hash result is: {"name"=>"Jim", "bio"=>"", "email"=>nil, "rotting"=>false, "age"=>20, "decomp"=>"fresh", "brain"=>{"flavour"=>"Strawberry"}}

end
