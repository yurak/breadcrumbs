module Breadcrumbs
  class NamespaceParser
    NAMESPACE = 'settings'.freeze

    def self.crumb(url:, controller_name:)
      if url.split('/').include?(NAMESPACE) && controller_name != NAMESPACE
        { title: I18n.t(:title, scope: [NAMESPACE.to_sym, :index]), url: [NAMESPACE] }
      end
    end
  end
end
