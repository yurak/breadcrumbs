module Breadcrumbs
  class Collector
    attr_reader :controller_breadcrumbs, :action_name, :namespace_crumb, :not_index_crumb

    def initialize(controller_breadcrumbs:, action_name:, namespace_crumb:, not_index_crumb:)
      @controller_breadcrumbs = controller_breadcrumbs
      @action_name = action_name
      @namespace_crumb = namespace_crumb
      @not_index_crumb = not_index_crumb
      @breadcrumbs = [Crumb.for_root]
    end

    def self.collect(*args)
      new(*args).collect
    end

    def collect
      return [] unless controller_breadcrumbs.present?

      @breadcrumbs << namespace_crumb if namespace_crumb.present?

      unless controller_breadcrumbs == true
        @breadcrumbs += controller_breadcrumbs.compact.flatten
      end

      @breadcrumbs << not_index_crumb unless action_index?

      @breadcrumbs
    end

    private

    def action_index?
      action_name == Breadcrumbs::CRUDCreator::INDEX
    end
  end
end
