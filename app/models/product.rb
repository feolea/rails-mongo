class Product
  include Mongoid::Document
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates :ean, length: { minimum: 8, maximum: 13, allow_blank: true }
  validates :price, numericality: { greater_than: 0 }
  validates :name, presence: true
  validates :sku, format: { 
    with: /\A[a-zA-Z0-9\-]+\z/,
    message: "It's allowed to use only alphanumeric or hyphen digits",
    allow_blank: true
  }

  before_save :touch

  index_name "products-#{Rails.env}"

  field :sku, type: String
  field :name, type: String
  field :description, type: String
  field :ean, type: String
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