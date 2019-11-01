require 'json'
require 'octokit'

client = Octokit::Client.new
client.auto_paginate = true

`rm members/*.json`

client.org_members('github').each do |member|
  File.write("members/#{member.login}.json", JSON.pretty_generate(member.to_h))
end

`git add members && git commit -am "Update members" && git push origin master`