require 'json'
require 'octokit'

client = Octokit::Client.new
client.auto_paginate = true

`rm members/*.json`

cnt = 0
client.org_members('github').each do |member|
  cnt += 1
  File.write("members/#{member.login}.json", JSON.pretty_generate(member.to_h))
end

File.write("README.md", "# ex-github or not

This is a really simple script to track who publically joins / leaves github. It's possibly interesting due to the current sitation with ICE. Updates ~every 12h.

We started with 214 publically listed folks. The current count as of #{Date.today} is #{cnt}.")

puts `git pull && git add . && git commit -am "Update members" && git push origin master`
