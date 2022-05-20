class OauthController < ApplicationController
    def login
        redirect_to "https://discord.com/api/oauth2/authorize?client_id=972970452416860220&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Fprocess_oauth&response_type=code&scope=email%20identify", allow_other_host: true
    end

    def process_oauth
        url = "https://discord.com/api/oauth2/token"
        client_id = "972970452416860220"
        client_secret = "-Q94GPbrR7L0v6JFsCYmA6Lc7v1cXcPZ"

        code = params[:code]

        body = {
            :client_id => client_id,
            :client_secret => client_secret,
            :grant_type => 'authorization_code',
            :code => code,
            :redirect_uri => 'http://localhost:3000/process_oauth'
        }

        body = URI.encode_www_form(body)
        @result = HTTParty.post(url,
            :body => body,
            :headers => {
                'Content-Type' => 'application/x-www-form-urlencoded'
            })
        #.parsed_response["access_token"]
        
        @discord_user = HTTParty.get("https://discordapp.com/api/users/@me",
        {
            :headers => {
                'Authorization' => "Bearer #{@result.parsed_response["access_token"]}"
            }
        })
        @discord_user = @discord_user.parsed_response

        user = User.find_by(discord_id: @discord_user["id"])

        if !user
            user = User.new
            user.username = @discord_user["username"]
            user.discord_id = @discord_user["id"]
            user.email = @discord_user["email"]
            user.password = @discord_user["id"]
        end
        user.avatar = @discord_user["avatar"]

        user.save!

        sign_in_and_redirect user

    end
end
