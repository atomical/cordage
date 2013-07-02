class MediaAsset < ActiveFedora::Base
  has_many :users, primary_key: 'id', property: :isPartOf, class: 'User'
end