# frozen_string_literal: true

require 'spec_helper'

describe PlugThumbnailer::Page do

  let(:url)       { 'http://foo.com' }
  let(:instance)  { described_class.new(url, options) }

  context 'with inline options' do

    let(:options) { { image_limit: 2 } }

    it { expect(instance.config.image_limit).to eq(2) }
    it { expect(instance.config.user_agent).to eq(PlugThumbnailer.config.user_agent) }

  end

  context 'without inline options' do

    let(:options) { {} }

    it { expect(instance.config.image_limit).to eq(PlugThumbnailer.config.image_limit) }
    it { expect(instance.config.user_agent).to eq(PlugThumbnailer.config.user_agent) }

  end

end
