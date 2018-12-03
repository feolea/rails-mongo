
RSpec.describe Products::ReportJob do
  context 'when everything is fine' do
    it 'enqueues a ReportJob with params' do
      ActiveJob::Base.queue_adapter = :test
      params = { some: 'param' }

      described_class.perform_later(params)

      expect(described_class).to have_been_enqueued.with(params)
    end

    it 'calls open on CSV' do
      job = described_class.new
      path = Rails.root.join('tmp', 'reports')
      file = "#{path}/products-report#{Time.now.to_i}.csv"

      expect(CSV).to receive(:open).with(file, 'w')
      
      job.perform
    end

    it 'returns true' do
      job = described_class.new

      expect(job.perform).to be true
    end
  end

  context 'when File operation raises some error' do
    it 'returns false' do
      allow(CSV).to receive(:open).and_raise('Something went wrong!')

      job = described_class.new

      expect(job.perform).to be false
    end
  end
end
