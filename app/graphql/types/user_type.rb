Types::UserType = GraphQL::ObjectType.define do
  name "User"
  field :id, !types.ID
  field :email, !types.String
  field :name, !types.String
  field :microposts, types[Types::PostType]
end
