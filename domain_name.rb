=begin
Domain Name
Domain squatting is become a profession these days. That is where people buy up domains they think others will want in the future so that they can sell it later on. We're not going to do just that, but we will be building a tool to check if a domain name is available. There are several command line utilities that can help such as "nslookup". Your program (or function) should take in a string and return back if the domain is available or not.

Solution
=end

require 'resolv'

url = ARGV[0] ? ARGV[0] : ''
txt = Resolv::DNS.open do |dns|
  records = dns.getresources(url, Resolv::DNS::Resource::IN::TXT)
  records.empty? ? nil : records.map(&:data).join(" ")
end
puts txt ? 'not available' : 'available'
