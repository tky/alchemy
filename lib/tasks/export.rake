require 'csv'

namespace :export do
  desc 'export track data'
  task :execute => :environment do
    File.open("scripts/track.basket", "w") do |file|
      Track.select(:user_id).distinct.each do |track|
        file.puts(Track.where(user_id: track.user_id).pluck(:item_id).join(','))
      end
    end
  end

  task :import => :environment do
    CSV.foreach('scripts/associates.csv', :headers => false) do |row|
      Associate.create(supp: row[0].to_f, conf: row[1].to_f, lift: row[2].to_f, rule_left: row[3], rules_right: row[4])
    end
  end
end
