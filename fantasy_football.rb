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

# uris for espn and mengs data. currently needs to be updated weekly
espn_uris = {
    'rb'  => 'http://espn.go.com/fantasy/football/story/_/page/15ranksWeek2RB/fantasy-football-week-2-rankings-running-backs-top-25-rb',
    'wr'  => 'http://espn.go.com/fantasy/football/story/_/page/15ranksWeek2WR/fantasy-football-week-2-rankings-wide-receivers-top-25-wr',
    'qb'  => 'http://espn.go.com/fantasy/football/story/_/page/15ranksWeek2QB/fantasy-football-week-2-rankings-quarterbacks-top-25-qb',
    'def' => 'http://espn.go.com/fantasy/football/story/_/page/15ranksWeek2DST/fantasy-football-week-2-rankings-defenses-dst-def',
    'te'  => '',
    'k'   => '',
}
mengs_uris = {
    'rb'  => 'http://football9.myfantasyleague.com/2015/top?L=11945&SEARCHTYPE=BASIC&COUNT=300&YEAR=2015&START_WEEK=1&END_WEEK=1&CATEGORY=freeagent&POSITION=RB&DISPLAY=points&TEAM=*',
    'wr'  => 'http://football9.myfantasyleague.com/2015/top?L=11945&SEARCHTYPE=BASIC&COUNT=300&YEAR=2015&START_WEEK=1&END_WEEK=1&CATEGORY=freeagent&POSITION=WR&DISPLAY=points&TEAM=*',
    'qb'  => 'http://football9.myfantasyleague.com/2015/top?L=11945&SEARCHTYPE=BASIC&COUNT=300&YEAR=2015&START_WEEK=1&END_WEEK=1&CATEGORY=freeagent&POSITION=QB&DISPLAY=points&TEAM=*',
    'def' => 'http://football9.myfantasyleague.com/2015/top?L=11945&SEARCHTYPE=BASIC&COUNT=300&YEAR=2015&START_WEEK=1&END_WEEK=1&CATEGORY=freeagent&POSITION=Def&DISPLAY=points&TEAM=*',
    'te'  => 'http://football9.myfantasyleague.com/2015/top?L=11945&SEARCHTYPE=BASIC&COUNT=300&YEAR=2015&START_WEEK=1&END_WEEK=1&CATEGORY=freeagent&POSITION=TE&DISPLAY=points&TEAM=*',
    'k'   => 'http://football9.myfantasyleague.com/2015/top?L=11945&SEARCHTYPE=BASIC&COUNT=300&YEAR=2015&START_WEEK=1&END_WEEK=1&CATEGORY=freeagent&POSITION=PK&DISPLAY=points&TEAM=*',
}

type = ARGV[0] ? ARGV[0] : ''

# get espn weekly data
page = Nokogiri::HTML(open(espn_uris[type]))
rows = page.css('div.article-body')
# puts page.css('article.article')
# rows = page.xpath('//*[@id="rankings"]/tbody')
# rows = page.xpath('//table/tbody/tr[@class="last"]')
p rows
espn = rows.collect do |row|
  detail = {}
  [
      [:rank, 'td[1]'],
      [:name, 'td[2]/a'],
  ].each do |name, xpath|
    p detail
    detail[name] = row.at_xpath(xpath).text.strip
  end
  p detail
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

