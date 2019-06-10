class Survey < ActiveRecord::Base
  belongs_to :issue
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_one :comment, as: :commented, dependent: :delete
  acts_as_list

  attr_accessible :comentario, :nota, :issue_id
  attr_protected :id

  validates :comentario, presence: true, length: { minimum: 5 }
  validates :nota, presence: true, numericality: true

  def editable_by?(usr=User.current)
    usr && (usr.allowed_to?(:update_surveys, project) || (self.author == usr && usr.allowed_to?(:edit_own_surveys, project)))
  end

  def project
    self.issue.project if self.issue
  end

  def info
    "#{self.comentario} - #{self.nota} - #{self.issue_id}"
  end

  def true_if_rating_smaller_then_iterator(nota, i)
    if nota >= i
      true
    end
  end

  def get_author
    self.issue.author
  end

  def get_project
    self.issue.project
  end
end
