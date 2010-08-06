require 'date'
require 'net/http'

BASEURL = 'www.retrosheet.org'
OUTPUT_DIR = 'events'
system("mkdir -p #{OUTPUT_DIR}")

for year in 1950..(Date.today.year - 1) do
  filename = year.to_s + 'eve.zip'
  puts "Fetching file #{filename} from #{BASEURL}"
  Net::HTTP.start(BASEURL) { |http|
    resp = http.get("events/#{filename}")
    open(File.join(OUTPUT_DIR, filename), "wb") { |file|
      file.write(resp.body)
     }
  }
  # let's not slam the retrosheet servers... sleep for 10 seconds between each file request
  sleep 10
end

