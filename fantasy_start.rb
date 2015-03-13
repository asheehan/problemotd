=begin

Figure out who to start in a given week.

=end

require 'rubygems'
require 'nokogiri'
require 'mechanize'
require 'open-uri'

# uris for espn and mengs data. currently needs to be updated weekly
espn_uris = {
    'rb'  => 'http://espn.go.com/fantasy/football/story/_/page/14ranksWeek10RB/fantasy-football-Week-10-fantasy-football-running-back-rankings',
    'wr'  => 'http://espn.go.com/fantasy/football/story/_/page/14ranksWeek10WR/fantasy-football-Week-10-fantasy-football-wide-receiver-rankings',
    'qb'  => 'http://espn.go.com/fantasy/football/story/_/page/14ranksWeek10QB/fantasy-football-Week-10-fantasy-football-quarterback-rankings',
    'def' => 'http://espn.go.com/fantasy/football/story/_/page/14ranksWeek10DST/fantasy-football-Week-10-fantasy-football-defense-rankings',
    'te'  => 'http://espn.go.com/fantasy/football/story/_/page/14ranksWeek10TE/fantasy-football-week-10-fantasy-football-tight-end-rankings',
    'k'   => 'http://espn.go.com/fantasy/football/story/_/page/14ranksWeek10K/fantasy-football-week-10-fantasy-football-kicker-rankings',
}

# todo left this so that i can come back and add 'check waivers for better options' feature
mengs_uris = {
    'rb'  => 'http://football9.myfantasyleague.com/2014/top?L=16839&SEARCHTYPE=BASIC&COUNT=32&YEAR=2014&START_WEEK=1&END_WEEK=8&CATEGORY=freeagent&POSITION=RB&DISPLAY=points&TEAM=*',
    'wr'  => 'http://football9.myfantasyleague.com/2014/top?L=16839&SEARCHTYPE=BASIC&COUNT=32&YEAR=2014&START_WEEK=1&END_WEEK=8&CATEGORY=freeagent&POSITION=WR&DISPLAY=points&TEAM=*',
    'qb'  => 'http://football9.myfantasyleague.com/2014/top?L=16839&SEARCHTYPE=BASIC&COUNT=32&YEAR=2014&START_WEEK=1&END_WEEK=8&CATEGORY=freeagent&POSITION=QB&DISPLAY=points&TEAM=*',
    'def' => 'http://football9.myfantasyleague.com/2014/top?L=16839&SEARCHTYPE=BASIC&COUNT=32&YEAR=2014&START_WEEK=1&END_WEEK=8&CATEGORY=freeagent&POSITION=Def&DISPLAY=points&TEAM=*',
    'te'  => 'http://football9.myfantasyleague.com/2014/top?L=16839&SEARCHTYPE=BASIC&COUNT=32&YEAR=2014&START_WEEK=1&END_WEEK=9&CATEGORY=freeagent&POSITION=TE&DISPLAY=points&TEAM=*',
    'k'   => 'http://football9.myfantasyleague.com/2014/top?L=16839&SEARCHTYPE=BASIC&COUNT=32&YEAR=2014&START_WEEK=1&END_WEEK=9&CATEGORY=freeagent&POSITION=PK&DISPLAY=points&TEAM=*',
}

mechanize = Mechanize.new
page = mechanize.get('http://espn.go.com/fantasy/football/story/_/page/14ranksWeek10RB/fantasy-football-Week-10-fantasy-football-running-back-rankings')
type = ARGV[0] ? ARGV[0] : ''

# fetch all espn data
player_stats = Hash.new
espn_uris.each do |position, uri|
  page = mechanize.get(uri)
  rows = page.search('//table/tbody/tr[@class="last"]')
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
  player_stats[position] = espn
end
p player_stats['qb']

=begin

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

=end
