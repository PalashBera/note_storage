class Note
  include Mongoid::Document
  include Mongoid::TaggableOn
  include Mongoid::Timestamps
  field :title, type: String
  field :body, type: String

  taggable_on :tags

  belongs_to :user

  validates :title, presence: true, uniqueness: { case_sensetive: false, scope: :user_id }

  scope :order_by_date, -> { order(created_at: :desc) }

  def display_tags
    tags.join(", ")
  end

  def self.search(search)
    if search.present?
      search_keyword = /#{search}/i
      any_of({ title: search_keyword }, { body: search_keyword }, { tags: { "$in": [search] } }).order_by_date
    else
      order_by_date
    end
  end
end
