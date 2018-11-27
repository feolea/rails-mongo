require 'rails_helper'

RSpec.describe ReportJob do
  it 'enqueues a ReportJob with params' do
    params = { some: 'param' }

    ActiveJob::Base.queue_adapter = :test
    ReportJob.perform_later(params)

    expect(ReportJob).to have_been_enqueued.with(params)
  end
end
