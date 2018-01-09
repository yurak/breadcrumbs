module Breadcrumbs
  class Crumb
    def self.for_root
      { title: I18n.t(:root, scope: :breadcrumbs), url: Breadcrumbs.root_path }
    end

    def self.not_index(title)
      { title: title, url: '#' }
    end
  end
end
