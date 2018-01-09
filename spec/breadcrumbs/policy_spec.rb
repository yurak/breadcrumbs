require 'breadcrumbs'

describe Breadcrumbs::Policy do
  describe '#child?' do
    let(:params) { {} }

    subject      { described_class.child?(params) }

    before { allow(Breadcrumbs).to receive(:parent_ids).and_return %i(some_id some_id_2) }

    context 'returns false if intersection of sets returns empty set' do
      it { is_expected.to be false }
    end

    context 'params presenets and matches parent_ids' do
      let(:params) { { some_id: 2 } }

      it { is_expected.to be true }
    end
  end
end
