require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "pizzashop.db"}

class Product < ActiveRecord::Base

end

class Client < ActiveRecord::Base
  validates :name, presence: true
  validates :phone, presence: true
  validates :adress, presence: true
  validates :order, presence: true
end

before do
        @clients = Client.all
end


get '/' do
  @products = Product.all
	erb :index			
end

get '/about' do
  erb :about
end


get '/cart' do
  @c = Client.new
  @products = Product.all
  @hawaiian = 0
  @pepperoni = 0
  @vegetarian = 0
  orderstext = params[:orders].split(",")
  orderstext.each do |n|
    if n.include? "product_1="
      n = n[10..-1]
      @hawaiian = n.to_i
    end
    if n.include? "product_2="
      n = n[10..-1]
      @pepperoni = n.to_i
    end
    if n.include? "product_3="
      n = n[10..-1]
      @vegetarian = n.to_i
    end
  end
  erb :cart
end

post '/cart' do
  @products = Product.all
  @c = Client.new
  @hawaiian = 0
  @pepperoni = 0
  @vegetarian = 0
  orderstext = params[:orders].split(",")
  orderstext.each do |n|
    if n.include? "product_1="
      n = n[10..-1]
      @hawaiian = n.to_i
    end
    if n.include? "product_2="
      n = n[10..-1]
      @pepperoni = n.to_i
    end
    if n.include? "product_3="
      n = n[10..-1]
      @vegetarian = n.to_i
    end
  end
  erb :cart
end



post '/order' do
@products = Product.all
@hawaiian = 0
  @pepperoni = 0
  @vegetarian = 0
  @orderstext = params[:finalorders].split(",")
  @orderstext.each do |n|
    if n.include? "product_1="
      n = n[10..-1]
      @hawaiian = n.to_i
    end
    if n.include? "product_2="
      n = n[10..-1]
      @pepperoni = n.to_i
    end
    if n.include? "product_3="
      n = n[10..-1]
      @vegetarian = n.to_i
    end
  end

  @c = Client.new params[:client]
  if @c.save
    erb "<h2>Thank you for your order!</h2>"
  else
    @error = @c.errors.full_messages.first
    

  
    erb :cart
  end
end