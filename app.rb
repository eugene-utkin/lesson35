require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "pizzashop.db"}

class Product < ActiveRecord::Base

end



get '/' do
  @products = Product.all
	erb :index			
end

get '/about' do
  erb :about
end


post '/cart' do
  orders = params[:orders]
  @items = parse_orders_line orders

  @items.each do |item|
    item[0] = Product.find(item[0])
  end

  erb :cart
end

def parse_orders_line orders
        s1 = orders.split(/,/)
        arr = []
        s1.each do |x|
                s2 = x.split(/=/)
                s3 = s2[0].split(/_/)
                id = s3[1]
                cnt = s2[1]
                arr2 = [id, cnt]
                arr.push arr2
        end
        return arr
end