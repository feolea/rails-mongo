Elasticsearch::Model.client = Elasticsearch::Client.new url:
  ENV['ELASTICSEARCH_URL'] || 'http://localhost:9200/'

unless Product.__elasticsearch__.index_exists?
  Product.__elasticsearch__.create_index! force: true
  Product.import
end
