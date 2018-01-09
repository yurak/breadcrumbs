module Breadcrumbs
  module Policy
    def self.child?(params)
      (params.keys & Breadcrumbs.parent_ids).present?
    end
  end
end
