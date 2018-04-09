Types::PostType = GraphQL::ObjectType.define do
  name "Post"
  description "A blog post"
  field :content, !types.String
  field :id, !types.ID
  field :created_at, !types.String
end
