Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  # TODO: remove me
  field :testField, types.String do
    description "An example field added by the generator"
    resolve ->(obj, args, ctx) {
      "Hello World!"
    }
  end

  field :post, description: "Find a Post by ID", function: Resolvers::GetMicroposts.new
  field :allMicroposts, function: Resolvers::SearchMicropost

  field :user do
    type Types::UserType
    argument :id, !types.ID
    description "Find a Article by ID"
    resolve -> (obj, args, ctx) { User.find_by_id(args["id"]) }
  end
end
