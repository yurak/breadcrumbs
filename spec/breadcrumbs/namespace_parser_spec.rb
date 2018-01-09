require 'breadcrumbs'

describe Breadcrumbs::NamespaceParser do
  describe '#crumb' do
    let(:namespace_crumb) { { title: "translation missing: en.settings.index.title", url: ["settings"]} }
    let(:options) { {url: 'settings/users/1', controller_name: 'users'} }

    subject { described_class.crumb(options) }

    context 'url has namepsace' do
      it { is_expected.to eq namespace_crumb }
    end

    context 'url does not have default namepsace' do
      let(:options) { {url: 'othernamespace/users/1', controller_name: 'users'} }

       it { is_expected.to be nil }
    end
  end
end
