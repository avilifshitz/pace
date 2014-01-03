class User < ActiveRecord::Base
	has_one :goal, dependent: :destroy
  has_many :conversations, dependent: :destroy
  belongs_to :mentor, foreign_key: :mentor_id, class_name: "User"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  attr_accessor :goal_title,:goal_from,:goal_to,:miles_title,:miles_from,:miles_to
    
	after_create :call_after_create

  # mailboxer
  acts_as_messageable

  # mailboxer
  def name
    return :email
  end

  # mailboxer
  def mailboxer_email(object)
    return self.email
  end

	def call_after_create
    unless self.is_mentor?
      goal=Goal.create!(user_id: self.id, title: self.goal_title,from: self.goal_from,to: self.goal_to)
      Milestone.create!(goal_id: goal.id, title: self.miles_title,from: self.miles_from,to: self.miles_to)
    end
  end

end
