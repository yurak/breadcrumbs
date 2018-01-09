require 'breadcrumbs'

describe Breadcrumbs::CRUDCreator do
  let(:controller_label) { 'ParentController' }
  let(:controller_label2) { 'ChildController' }
  let(:controller_url) { 'parent_controller' }
  let(:controller_url2) { 'child_controller' }
  let(:controller_without_index_label) { 'WithoutIndex Controller' }
  let(:model) { double(model_name: double(to_s: 'TestModel'), id: 2, label: 'TestModel Object') }
  let(:test_controller_class) do
    Class.new do
      attr_accessor :params, :action_methods, :controller_name
    end
  end
  let(:parent_controller) { test_controller_class.new }
  let(:child_controller) { test_controller_class.new }
  let(:controller_without_index) { test_controller_class.new }
  let(:test_object) do
    Class.new do
      attr_accessor :label
    end.new
  end

  before do
    allow(Breadcrumbs).to receive(:parent_ids).and_return []

    parent_controller.params = { 'action' => 'index', 'controller' => 'controllers', 'id' => 2 }
    parent_controller.action_methods = [described_class::INDEX]
    parent_controller.controller_name = controller_url
  end

  context 'sets breadcrumbs for parent_controller' do
    subject { described_class.prepare_params(parent_controller, test_object, breadcrumbs_nested: true) }

    before { allow(I18n).to receive(:t).and_return controller_label }

    it 'for index action' do
      expect(subject).to eq([{ title: controller_label, url: [controller_url.to_sym] }])
    end

    it 'for show action sets the same' do
      parent_controller.params['action'] = 'show'

      expect(subject).to eq([{ title: controller_label, url: [controller_url.to_sym] }])
    end
  end

  context 'sets breadcrumbs for nested controller' do
    subject { described_class.new(child_controller, test_object, breadcrumbs_nested: false) }

    before do
      allow(Breadcrumbs).to receive(:parent_ids).and_return ['controller_id']

      child_controller.params = { 'action' => 'index', 'controller' => controller_url2, 'controller_id' => 2 }
      child_controller.action_methods = [described_class::INDEX]
      child_controller.controller_name = controller_url2
      child_controller.instance_variable_set('@controller', model)
      allow(I18n).to receive(:t).with('test_models.index.title').and_return controller_label
      allow(I18n).to receive(:t).with("#{controller_url2}.index.title").and_return controller_label2
    end

    it 'sets 3 crumbs for nested index action' do
      expect(subject.prepare_params.count).to eq 3
    end

    it 'sets index crumb' do
      expect(subject.send(:index_crumb, test_object)).to eq({ title: controller_label2, url: [controller_url2.to_sym] })
    end

    it 'sets parent_index_crumb' do
      expect(subject.send(:parent_index_crumb)).to eq({ title: controller_label, url: [:test_models] })
    end

    it 'sets parent_show_crumb title eq to model label' do
      expect(subject.send(:parent_show_crumb)[:title]).to eq model.label
    end

    it 'sets parent_show_crumb url' do
      expect(subject.send(:parent_show_crumb)[:url]).to match_array [model]
    end
  end

  context 'sets breadcrumbs for settings_controller' do
    subject { described_class.new(controller_without_index, test_object, breadcrumbs_nested: true) }

    before do
      allow(Breadcrumbs).to receive(:parent_ids).and_return ['controller_id']

      controller_without_index.instance_variable_set('@controller', model)
      controller_without_index.params = { 'action' => 'show', 'controller' => 'settings', 'controller_id' => 2 }
      controller_without_index.action_methods = []
      controller_without_index.controller_name = controller_without_index_label
    end

    it 'does not set index crumb for controller without index' do
      expect(subject.prepare_params.count).to eq 2
    end
  end
end
