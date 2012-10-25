namespace :errbit do

  desc "Create apps based on config/apps.yml"
  task :create_apps => :environment do
    YAML::load_documents(File.open(Rails.root.join('config', 'apps.yml'))) do |app|
      puts app
      begin
        App.find_by_api_key!(app[:api_key])
      rescue
        App.create(app.merge(:watchers => [{:email =>"govuk-exceptions@digital.cabinet-office.gov.uk"}]))
      end
    end
  end
end