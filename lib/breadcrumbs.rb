require 'action_view'
require 'active_support/inflector'

module Breadcrumbs
  mattr_accessor :logger, :root_path, :show_errors, :parent_ids
  @@parent_ids = []

  autoload :CRUDCreator,     File.expand_path('breadcrumbs/crud_creator', __dir__)
  autoload :Policy,          File.expand_path('breadcrumbs/policy', __dir__)
  autoload :Helpers,         File.expand_path('breadcrumbs/helpers', __dir__)
  autoload :Collector,       File.expand_path('breadcrumbs/collector', __dir__)
  autoload :NamespaceParser, File.expand_path('breadcrumbs/namespace_parser', __dir__)
  autoload :Crumb,           File.expand_path('breadcrumbs/crumb', __dir__)
end
