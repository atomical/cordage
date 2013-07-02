class DocumentAsset < ActiveFedora::Base
  include Hydra::ModelMixins::CommonMetadata
  cordage :managers, primary_key: 'name'
  has_metadata name: "descMetadata", type: ModsDocument
end