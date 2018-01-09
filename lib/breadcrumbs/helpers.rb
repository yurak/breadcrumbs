module Breadcrumbs
  module Helpers
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::UrlHelper

    def collect_breadcrumbs
      ::Breadcrumbs::Collector.collect(
        controller_breadcrumbs: set_breadcrumbs,
        action_name: action_name,
        namespace_crumb: Breadcrumbs::NamespaceParser.crumb(url: request.url, controller_name: controller_name),
        not_index_crumb: Breadcrumbs::Crumb.not_index(@page_title_text)
      )
    end

    def render_breadcrumbs(breadcrumbs = collect_breadcrumbs)
      return unless breadcrumbs.present?

      breadcrumbs_text = ''.html_safe
      item_max_width_css = "max-width: #{(100.00 / breadcrumbs.count).floor}%;"

      content_tag(:div, class: 'breadcrumbs') do
        content_tag(:ul) do
          last = breadcrumbs.pop
          breadcrumbs.each do |breadcrumb|
            link = Breadcrumbs.show_errors ? rescue_breadcrumb(breadcrumb) : breadcrumb_link(breadcrumb)
            breadcrumbs_text << content_tag(:li, link, style: item_max_width_css)
          end
          if last
            breadcrumbs_text << content_tag(:li, class: :active, style: item_max_width_css) do
              content_tag :span, last[:title], title: last[:title]
            end
          end
        end
      end
    end

    def breadcrumb_link(breadcrumb, url = true)
      title = breadcrumb[:title]

      return link_to(title, '#', title: title) unless url

      link_to(title, breadcrumb[:url], title: title)
    end

    def rescue_breadcrumb(breadcrumb)
      breadcrumb_link(breadcrumb)
    rescue NoMethodError
      Breadcrumbs.logger.warn("URL for `#{ breadcrumb[:url] }` is invalid")
      breadcrumb_link(breadcrumb, false)
    end
  end
end
