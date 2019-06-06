class Survey < ActiveRecord::Base
  belongs_to :issue
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_one :comment, as: :commented, dependent: :delete
  acts_as_list

  attr_accessible :comentario, :nota, :issue_id
  attr_protected :id

  validates_presence_of :comentario, :nota

  def editable_by?(usr=User.current)
    usr && (usr.allowed_to?(:update_surveys, project) || (self.author == usr && usr.allowed_to?(:edit_own_surveys, project)))
  end

  def project
    self.issue.project if self.issue
  end

  def info
    "#{self.comentario} - #{self.nota} - #{self.issue_id}"
  end

end
