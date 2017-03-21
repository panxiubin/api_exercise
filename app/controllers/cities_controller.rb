class CitiesController < ApplicationController
  def index
    @cities = City.all
  end

  def update_temp
    city = City.find(params[:id])

    response = RestClient.get "http://v.juhe.cn/weather/index", :params => { :cityname => city.juhe_id, :key => "a12175bc38fadcd7bf7fda88b75c7d93" }

    data = JSON.parse(response.body)

    city.update( :current_temp => data["result"]["sk"]["temp"] )

    redirect_to cities_path
  end
end
