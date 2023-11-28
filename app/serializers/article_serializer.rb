class ArticleSerializer < ActiveModel::Serializer
  belongs_to :author
  has_many :comments
  attributes :id, :title, :content
end
