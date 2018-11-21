class Product
  include Mongoid::Document
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  before_save :touch

  index_name "products-#{Rails.env}"

  field :sku, type: String
  field :name, type: String
  field :description, type: String
  field :quantity, type: Integer
  field :price, type: Float
  field :inserted_at, type: DateTime
  field :updated_at, type: DateTime

  def as_indexed_json(_)
    as_json(except: [:id, :_id])
  end

  private

  def touch
    now = DateTime.now
    self.updated_at = now
    self.inserted_at = now unless inserted_at
  end
end