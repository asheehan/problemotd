=begin

Personal project to play around with some fantasy football stuff
example output (in descending order of preference)

$ ruby fantasy_football.rb qb
Robert Griffin III
Mike Glennon
Ryan Fitzpatrick
Austin Davis
Michael Vick
Blake Bortles
Derek Carr

=end

require 'rubygems'
require 'nokogiri'
require 'open-uri'

# get random seed via website with text/numbers
espn_uris = {
    'rb'  => 'http://espn.go.com/fantasy/football/story/_/page/14ranksWeek9RB/fantasy-football-Week-9-fantasy-football-running-back-rankings',
    'wr'  => 'http://espn.go.com/fantasy/football/story/_/page/14ranksWeek9WR/fantasy-football-Week-9-fantasy-football-wide-receiver-rankings',
    'qb'  => 'http://espn.go.com/fantasy/football/story/_/page/14ranksWeek9QB/fantasy-football-Week-9-fantasy-football-quarterback-rankings',
}
mengs_uris = {
    'rb'  => 'http://football9.myfantasyleague.com/2014/top?L=16839&SEARCHTYPE=BASIC&COUNT=32&YEAR=2014&START_WEEK=1&END_WEEK=8&CATEGORY=freeagent&POSITION=RB&DISPLAY=points&TEAM=*',
    'wr'  => 'http://football9.myfantasyleague.com/2014/top?L=16839&SEARCHTYPE=BASIC&COUNT=32&YEAR=2014&START_WEEK=1&END_WEEK=8&CATEGORY=freeagent&POSITION=WR&DISPLAY=points&TEAM=*',
    'qb'  => 'http://football9.myfantasyleague.com/2014/top?L=16839&SEARCHTYPE=BASIC&COUNT=32&YEAR=2014&START_WEEK=1&END_WEEK=8&CATEGORY=freeagent&POSITION=QB&DISPLAY=points&TEAM=*',
}

type = ARGV[0] ? ARGV[0] : ''

# get espn weekly data
page = Nokogiri::HTML(open(espn_uris[type]))
rows = page.xpath('//table/tbody/tr[@class="last"]')
espn = rows.collect do |row|
  detail = {}
  [
      [:rank, 'td[1]'],
      [:name, 'td[2]/a'],
  ].each do |name, xpath|
    detail[name] = row.at_xpath(xpath).text.strip
  end
  detail
end

# get available free agent data
page = Nokogiri::HTML(open(mengs_uris[type]))
rows = page.xpath('//*[@id="top"]/table/tbody/tr[position()>2]')
mengs = rows.collect do |row|
  detail = {}
  [
      [:rank, 'td[1]'],
      [:name, 'td[3]/a'],
  ].each do |name, xpath|
    detail[name] = row.at_xpath(xpath).text.strip
  end
  detail
end
#data cleanup
mengs.each do |p|
  name = p[:name].split(',')
  p[:rank] = p[:rank].to_i
  p[:name] = name.last.split(' ').first + ' ' + name.first.chomp(',')
end

# find the best options
names = mengs.map {|p| p[:name]}
espn.each do |player|
  if names.include?(player[:name])
    puts player[:name]
  end
end

