
RSpec.describe Services::Reports::Products::Enqueuer do
  context 'when job is not specified' do
    it 'calls perform_later at Products::ReportJob' do
      expect(Products::ReportJob).to receive(:perform_later).once

      described_class.call
    end

    it 'return an instance of Products::ReportJob' do
      expect(described_class.call).to be_an_instance_of(Products::ReportJob)
    end
  end

  context 'when other job is supplied' do
    it 'calls perform_later with params in this job' do
      job = double
      params = { any: 'thing' }

      allow(job).to receive(:perform_later).with(params).and_return(:ok)

      expect(described_class.call(job, params)).to eq(:ok)
    end
  end
end
