class Note
  include Mongoid::Document
  include Mongoid::TaggableOn
  include Mongoid::Timestamps
  field :title, type: String
  field :body, type: String

  taggable_on :tags

  belongs_to :user

  validates :title, presence: true, uniqueness: { case_sensetive: false, scope: :user_id }
  validates :body, presence: true

  scope :order_by_date, -> { order(created_at: :desc) }

  def display_tags
    tags.join(", ")
  end
end
