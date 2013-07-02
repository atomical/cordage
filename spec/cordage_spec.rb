require 'spec_helper'

describe Cordage do
  
  describe 'Our expectations of how ActiveFedora currently handles ActiveRecord associations' do
    before do
      @user = FactoryGirl.build(:user)
      @media_asset = FactoryGirl.build(:media_asset)
    end
    it 'accepts AR model' do
      @media_asset.users << @user
      @media_asset.users.count.should == 1
    end
  end

end