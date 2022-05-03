require 'nokogiri'
require 'watir'

def process_player_row(twire_link,scrim_name,player_data)

  name = player_data["player"]
  player = Player.find_by(name: name)

  if !player
    player = twire_link.player.new
    player.name = player_data["player"]

    player.save!
  end

  player_data.delete("player")
  #player_data.delete("twr")
  player_data["scrim_name"] = scrim_name
  player_data["deaths"] = player_data["died_1st"] + player_data["died_2nd"] + player_data["died_3rd"] + player_data["died_4th"]

  player_scrim = player.player_scrim.create(player_data)
  
  player.save!
  player_scrim.save!

end

def process_page(round_num, browser, scrim_name,twire_link)
  
  if PlayerScrim.where(scrim_name: scrim_name).length > 0
    #return
  end
  player_stats = "https://twire.gg/en/pubg/tournaments/tournament/646/na-live-scrims/player-stats?round=#{round_num}&group=lobby-1"
  team_stats = "https://twire.gg/en/pubg/tournaments/tournament/646/na-live-scrims/team-stats?round=#{round_num}&group=lobby-1"
  
  p round_num
  p player_stats
  puts "est"
  
  lobby = 1
  browser.goto "https://twire.gg/en/pubg/tournaments/tournament/646/na-live-scrims/player-stats?round=#{round_num}&group=lobby-#{lobby}"
  doc = Nokogiri::HTML.parse(browser.html)
  flag = true
  while flag do
    headers = []
    doc.xpath('//*/table/thead/tr/td').each do |th|
      header = th.text.downcase
      
      header = header.gsub(/( |\/)/, "_")
      header = header.gsub(/(\(|\))/,"")

      headers << header
    end
    table = doc.xpath('//*/table/tbody/tr')

    if table
      table.collect.each_with_index do |row, i|
        data = {}      
        player_data = row.xpath('td')

        if player_data
          player_data.each_with_index do |td, j|
            data[headers[j]] = td.text
          end
          process_player_row(twire_link,scrim_name,data)
        end
      end
    end
    
    lobby += 1
    browser.goto "https://twire.gg/en/pubg/tournaments/tournament/646/na-live-scrims/player-stats?round=#{round_num}&group=lobby-#{lobby}"#player_stats
    if !browser.url.include? "blank"
      puts browser.url
      flag = false
      break
    end
  end

end

def itr_scrims(browser, twire_link)
  puts "e"
  scrim_date_button = browser.button(class: 'TournamentFilter_trigger__qk72K')
  scrim_date_button.click
  scrim_browser = Watir::Browser.new :firefox
  doc = Nokogiri::HTML.parse(browser.html)
  scrims = doc.css(".TournamentFilter_dropdown__hZds8").children.each
  scrims.drop(2)

  scrim_ids = []
  scrims.each_with_index do |temp, index|


    browser.button(value: temp.text).click

    scrim_date_button = browser.button(class: 'TournamentFilter_trigger__qk72K')
    scrim_name = scrim_date_button.text
    scrim_date_button.click

    round_num = browser.url.to_s[/#{"round="}(.*?)#{"&"}/m, 1]
    process_page(round_num,scrim_browser,scrim_name,twire_link)
  end
end

class AdminsController < ApplicationController
  def populate_database
    PlayerScrim.destroy_all
    Player.destroy_all
    browser = Watir::Browser.new :firefox
    # browser.goto 'https://twire.gg/en/pubg/tournaments/tournament/646/na-live-scrims/leaderboards?round=041822&group=lobby-1'

    TwireLink.all.each do |twire_link|
      browser.goto twire_link.link
      itr_scrims(browser,twire_link)
    end
  end

  def index
  end
end
