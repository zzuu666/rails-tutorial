require 'search_object/plugin/graphql'

class Resolvers::SearchMicropost
  # include SearchObject for GraphQL
  include SearchObject.module(:graphql)

  # scope is starting point for search
  scope { Micropost.all }

  # return type
  type !types[Types::PostType]

  # inline input type definition for the advance filter
  MicropostFilter = GraphQL::InputObjectType.define do
    name 'MicropostFilter'

    argument :OR, -> { types[MicropostFilter] }
    argument :content_contains, types.String
  end

  # when "filter" is passed "apply_filter" would be called to narrow the scope
  option :filter, type: MicropostFilter, with: :apply_filter

  # apply_filter recursively loops through "OR" branches
  def apply_filter(scope, value)
    # normalize filters from nested OR structure, to flat scope list
    branches = normalize_filters(value).reduce { |a, b| a.or(b) }
    scope.merge branches
  end

  def normalize_filters(value, branches = [])
    # add like SQL conditions
    scope = Micropost.all
    # scope = scope.like(:content, value['content_contains']) if value['content_contains']
    scope = scope.where('content LIKE ?', "%#{value['content_contains']}%") if value['content_contains']

    branches << scope

    # continue to normalize down
    value['OR'].reduce(branches) { |s, v| normalize_filters(v, s) } if value['OR'].present?

    branches
  end
end