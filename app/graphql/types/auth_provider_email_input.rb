Types::AuthProviderEmailInput = GraphQL::InputObjectType.define do
  name 'AUTH_PROVIDER_EMAil'

  argument :email, !types.String
  argument :password, !types.String
end