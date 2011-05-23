desc 'Load Redmetrics needed data (trackers, issue statuses, issue priorities and custom fields)'

namespace :redmetrics do
  task :create_data => :environment do
    begin
      Redmetrics::Loaders::CreateData.load
      puts 'Default redmetrics configuration data loaded.'
    rescue => error
      puts "Error: #{error}"
      puts 'Default redmetrics configuration data was not loaded.'
    end
  end
end
