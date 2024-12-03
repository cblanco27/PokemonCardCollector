require 'ostruct'
class TcgApiService

#Services is where you should put classes that aren't things you should put in any of the MVC

  def search_card(card_name, set, card_type)
    #calls the API, will give a json response(response status, headers, body(the cards)) 
    response = Faraday.get("https://api.pokemontcg.io/v2/cards", {pageSize: 20, q: "name:*#{card_name}*"}) # * will look for things that are not exact match
    json = JSON.parse(response.body, symbolize_names: true)

    json[:data].map do |card| #creates array of mapped data
      hash = {
        card_name: card[:name],
        set: card[:set][:name],
        card_type: card[:types].join(', '),
        card_price: card[:tcgplayer][:prices][:holofoil],
      } #creates hash of array, to allow the card data to show in current w/o modification
      OpenStruct.new(hash)
    end
  end
end