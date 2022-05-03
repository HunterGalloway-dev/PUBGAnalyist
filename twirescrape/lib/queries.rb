module Twire
    Query = SWAPI::Client.parse <<-'GRAPHQL'
    {
        luke: human(id: "1000") {
        ...Human::Fragment
        }
        leia: human(id: "1003") {
        ...Human::Fragment
        }
    }
    GRAPHQL
end