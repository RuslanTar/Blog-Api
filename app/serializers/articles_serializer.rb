class ArticlesSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :updated_at

  def body
    object.body.truncate(200, separator: ' ')
  end
end