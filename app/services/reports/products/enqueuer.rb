module Services
  module Reports
    module Products
      class Enqueuer
        def self.call(job = ::Products::ReportJob, *args)
          job.perform_later(*args)
        end
      end
    end
  end
end