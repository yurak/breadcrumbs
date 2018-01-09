require 'breadcrumbs'

describe Breadcrumbs::Helpers do
  let(:test_controller_class) do
    Class.new do
      include Breadcrumbs::Helpers

      attr_accessor :params, :action_methods, :controller_name, :action_name, :request, :output_buffer,
                    :_routes, :controller, :default_url_options

      def t(*args)
        "Title of #{args}"
      end
    end
  end
  let(:object) { test_controller_class.new }
  let(:url) { 'https://url.com' }

  describe '#render_breadcrumbs' do
    def breadcrumbs_expect
      return unless block_given?
      html = object.render_breadcrumbs
      yield html
    end

    before do
      object.request = double(url: url)

      Breadcrumbs.show_errors = false
      Breadcrumbs.root_path = '/'
      object.instance_variable_set('@page_title_text', 'Title')
    end

    it 'renders breadcrumbs markup' do
      allow(object).to receive(:set_breadcrumbs).and_return [{ title: 'title', url: url }]
      expect(object.render_breadcrumbs).to match '<div class="breadcrumbs">'
      expect(object.render_breadcrumbs).to match "href=\"#{url}\""
    end

    context 'sets' do
      before { allow(object).to receive(:set_breadcrumbs).and_return [{ title: 'title', url: url }] }

      context 'stubbed with true' do
        before { allow(object).to receive(:set_breadcrumbs).and_return true }

        it 'does not have to set the link' do
          breadcrumbs_expect do |html|
            expect(html).to match 'href="/"'
            expect(html).not_to match "href=\"#{url}\""
          end
        end
      end

      context 'index action' do
        it 'does not have to set the link' do
          object.action_name = 'index'

          breadcrumbs_expect do |html|
            expect(html).to match 'href="/"'
            expect(html).not_to match "href=\"#{url}\""
          end
        end
      end

      context 'other actions' do
        it 'sets the link' do
          object.action_name = 'show'

          breadcrumbs_expect do |html|
            expect(html).to match 'href="/"'
            expect(html).to match "href=\"#{url}\""
          end
        end
      end
    end
  end
end
