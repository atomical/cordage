require 'spec_helper'

describe Cordage do
  
  describe 'Our expectations of how ActiveFedora currently handles ActiveRecord associations' do
    before do
      @user = FactoryGirl.build(:user)
      @media_asset = FactoryGirl.build(:media_asset)
    end
    it 'rejects a model that inherits from ActiveRecord' do
      expect{ @media_asset.users << @user }.to raise_error
    end
  end

  describe 'Options' do
    before do
      @user = FactoryGirl.create(:user)
      @document = FactoryGirl.create(:document_asset)
    end

    it 'handles the primary key correctly' do
      @document.managers << @user
    end

  end

end