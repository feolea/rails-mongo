require 'csv'

class ReportJob < ApplicationJob
  queue_as :default

  def perform(*args)
    generate_report_file
  end

  private

  def generate_report_file
    CSV.open("#{path}/products-report#{Time.now.to_i}.csv", 'w') do |csv|
      csv << ['name', 'sku', 'description', 'quantity', 'price', 'ean']
      products.each do |p|
        csv << [p.name, p.sku, p.description, p.quantity, p.price, p.ean]
      end
    end

    true
  rescue StandardError
    false
  end

  def products
    @products ||= Product.all
  end

  def path
    @path ||= Rails.root.join('tmp', 'reports')
  end
end
