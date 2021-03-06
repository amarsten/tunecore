RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.filter_run_when_matching :focus

  config.example_status_persistence_file_path = "spec/examples.txt"

  config.disable_monkey_patching!

  
  if config.files_to_run.one?
    config.default_formatter = "doc"
  end

  #config.profile_examples = 10

  config.order = :random

  Kernel.srand config.seed

  config.before(:each) do
    @rem = Artist.create! name: "R.E.M."
    @drugdealer = Artist.create! name: "Drugdealer"
    @ramones = Artist.create! name: "The Ramones"
    @war_on_drugs = Artist.create! name: "The War On Drugs"

    @dead_letter = Album.create! name: "Dead Letter Office", artist: @rem
    @comedy = Album.create! name: "The End of Comedy", artist: @drugdealer
    @rocket = Album.create! name: "Rocket to Russia", artist: @ramones
    @dream = Album.create! name: "Lost In The Dream", artist: @war_on_drugs

    @rockaway_theme = Track.create! name: "Far Rockaway Theme", artist: @drugdealer, album: @comedy
    @alessandro = Track.create! name: "Theme For Alessandro", artist: @drugdealer, album: @comedy

    @walter = Track.create! name: "Walter's Theme", artist: @rem, album: @dead_letter
    @femme = Track.create! name: "Femme Fatale", artist: @rem, album: @dead_letter

    @rockaway_beach = Track.create! name: "Rockaway Beach", artist: @ramones, album: @rocket
    @sheena = Track.create! name: "Sheena Is A Punk Rocker", artist: @ramones, album: @rocket
    @dance = Track.create! name: "Do You Wanna Dance?", artist: @ramones, album: @rocket

    @red_eyes = Track.create! name: "Red Eyes", artist: @war_on_drugs, album: @dream
    @pressure = Track.create! name: "Under The Pressure", artist: @war_on_drugs, album: @dream

  end

end
