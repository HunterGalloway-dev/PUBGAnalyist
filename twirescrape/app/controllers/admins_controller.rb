require 'nokogiri'
require 'watir'

def process_player_data(player_data,scrim_id,twire_link,scrim_name)
  if player_data.length == 0
    return false
  end
  name = player_data["player"]
  player = Player.find_by(name: name)

  if !player
    player = twire_link.player.new
    player.name = player_data["player"]

    player.save!
  end

  player_data.delete("player")
  #player_data.delete("twr")
  player_data["scrim_id"] = scrim_id
  player_data["scrim_name"] = scrim_name
  player_data["deaths"] = (player_data["died_1st"].to_i + player_data["died_2nd"].to_i + player_data["died_3rd"].to_i + player_data["died_4th"].to_i)

  player_scrim = player.player_scrim.create(player_data)
  
  player.save!
  player_scrim.save!
end

# Avoid using links, use DOM elements instead
# Make it more readable than the older version
# Parallism

def get_player_data(scrim_browser,round_num,twire_link,scrim_name)
    player_url = "https://twire.gg/en/pubg/tournaments/tournament/646/na-live-scrims/player-stats?round=#{round_num}&group="
    
    scrim_browser.goto player_url
    scrim_browser.div(class: 'TournamentFilter_groups__11S87').children.each do |lobby|
        lobby.wait_until.click
        
        #puts 
        if scrim_browser.p(class: "ComponentError_errorMessage__2loAu").wait_until.exist?
            next
        end

        if !scrim_browser.table(class: "AdvancedTable_table__2IV4Y").wait_until.exist?
            puts scrim_browser.table(class: "AdvancedTable_table__2IV4Y").wait_until.exist?
            next
        end
        
        scrim_browser.table(class: "AdvancedTable_table__2IV4Y").wait_until.each do |row|
        end

        doc = Nokogiri::HTML.parse(scrim_browser.html)

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
                    process_player_data(data,round_num,twire_link,scrim_name)
                end
            end
        end

        
    end

    return 1
end

def process_team_data(data,scrim_id,twire_link,scrim_name)
    puts "data"
    team_name = data["team_name"]
    team = Team.find_by(team_name: team_name)

    if !team
        team = twire_link.team.new
        team.team_name = team_name

        team.save!
    end

    data.delete("team_name")
    data["scrim_id"] = scrim_id
    data["scrim_name"] = scrim_name

    team_scrim = team.team_scrim.create(data)

    team_scrim.save!
    team.save!
end

def get_teams_data(scrim_browser,round_num,twire_link,scrim_name)
    teams_url = "https://twire.gg/en/pubg/tournaments/tournament/646/na-live-scrims/team-stats?round=#{round_num}&group="
    scrim_browser.goto teams_url
    if scrim_browser.p(class: "ComponentError_errorMessage__2loAu").wait_until.exist? || !scrim_browser.table(class: "AdvancedTable_table__2IV4Y").wait_until.exist?
        return false
    end
    
    scrim_browser.div(class: 'TournamentFilter_groups__11S87').children.each do |lobby|
        lobby.wait_until.click
        
        scrim_browser.table(class: "AdvancedTable_table__2IV4Y").wait_until.each do |row|
        end

        doc = Nokogiri::HTML.parse(scrim_browser.html)

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
                    process_team_data(data,round_num,twire_link,scrim_name)
                end
            end
        end
    end
end


def process_page(scrim_browser,round_num,twire_link,scrim_name)
    #round_num = "04272022"
    #scrim_name = "04/27/2022"
    #byebug
    #scrim_browser = Watir::Browser.new :firefox
    ret = 0
    procs = 0
    puts !PlayerScrim.exists?(scrim_id: round_num)
    if !PlayerScrim.exists?(scrim_id: round_num)
        #puts "GOOO"
        procs = get_player_data(scrim_browser,round_num,twire_link,scrim_name)
        ret = 1
    end

    puts !TeamScrim.exists?(scrim_id: round_num)
    if !TeamScrim.exists?(scrim_id: round_num)
        get_teams_data(scrim_browser,round_num,twire_link,scrim_name)
    end

    return ret, procs
    
    #scrim_browser.close
end

# twire_link = initial link to the scrim event we want to collect data on
def itr_scrims(twire_link)
    scrim_browser = Watir::Browser.new :firefox
    browser = Watir::Browser.new :firefox
    cnt = 1
    
    invalid_scrims = []
    #while cnt != 0
    procsCnt = 0
    index = 0
    cnt = 1

    browser.goto twire_link.link

    # Select event filter dropdown to show all recorded events
    scrims_data_dropdown = browser.button(class: 'TournamentFilter_trigger__qk72K')
    scrims_data_dropdown.wait_until.click
    
    doc = Nokogiri::HTML.parse(browser.html)
    scrims = doc.css('.TournamentFilter_dropdown__hZds8').children
    # Loop through each button and click it to show the page we want to see
    threads = []
    while cnt != 0
        cnt = 0
        scrims.each_with_index do |scrim_button, index|
            # Click on individual scrim 

            browser.button(value: scrim_button.text).wait_until.click

            round_num = browser.url.to_s[/#{"round="}(.*?)#{"&"}/m, 1]
            x,y = process_page(scrim_browser,round_num,twire_link,scrim_button.text)

            if y != 0
                invalid_scrim = {}
                invalid_scrim["round_num"] = round_num
                invalid_scrim["scrim_name"] = scrim_button.text

                invalid_scrims << invalid_scrim
            end
            cnt += y

            # reopen dropdown
            scrims_data_dropdown.wait_until.click

            puts cnt
        end

        sleep 2.minutes
        puts cnt
    end
end

def testing(url)
    browser = Watir::Browser.new :firefox
    browser.goto url

    browser.div(class: 'TournamentFilter_groups__11S87').children.each.drop(1) do |lobby|
        puts lobby.text
    end
end

class AdminsController < ApplicationController
  def populate_database
    #InvalidLink.destroy_all
    #PlayerScrim.destroy_all
    #Player.destroy_all
    #Team.destroy_all
    #TeamScrim.destroy_all

    TwireLink.all.each do |twire_link|
      itr_scrims(twire_link)
    end
  end

  def index
  end

  def links
    @links = InvalidLink.all 
  end
end
