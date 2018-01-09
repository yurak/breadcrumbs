require 'breadcrumbs'

describe Breadcrumbs::Crumb do
  describe '#for_root' do
    let(:root_crumb) { {title: "translation missing: en.breadcrumbs.root", url: '/'} }
    before { allow(Breadcrumbs).to receive(:root_path).and_return '/' }
    subject { described_class.for_root }

    it { is_expected.to eq root_crumb }
  end

  describe '#not_index' do
    let(:not_index) { {title: 'test_title', url: "#"} }
    subject { described_class.not_index('test_title') }

    it { is_expected.to eq not_index }
  end
end
