class Resolvers::GetMicroposts < GraphQL::Function
  type types[Types::PostType]

  def call(_obj, args, ctx)
    user = ctx[:current_user]
    user.microposts.all
  end
end