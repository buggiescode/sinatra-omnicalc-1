require "sinatra"
require "sinatra/reloader"
require "money"

get("/") do
  erb(:homepage)
end

get("/square/new") do
  erb(:square_new)
end

get("/square/results") do
  @num_to_square = params.fetch("number").to_f
  @num_squared = @num_to_square ** 2
  erb(:square_results)
end

get("/square_root/new") do
  erb(:square_root_new)
end

get("/square_root/results") do
  @num_to_square_root = params.fetch("number").to_f
  @num_rooted = @num_to_square_root ** 0.5
  erb(:square_root_results)
end

get("/payment/new") do
  erb(:payment_new)
end

get("/payment/results") do
  apr = params.fetch("user_apr").to_f
  @apr_formatted = sprintf("%.4f%%", apr)
  prin = params.fetch("user_pv").to_i
  @principal = Money.new(prin*100, "USD").format
  @num_years = params.fetch("user_years").to_i

  monthly_interest_rate = apr / 12 / 100
  total_payments = 12 * @num_years
  monthly_payment = prin * monthly_interest_rate / (1 - (1 + monthly_interest_rate)**-total_payments)
  @payment = Money.new(monthly_payment*100, "USD").format

  erb(:payment_results)
end

get("/random/new") do
  erb(:random_new)
end

get("/random/results") do
  @min = params.fetch("user_min").to_f
  @max = params.fetch("user_max").to_f
  @rand_num = rand(@min..@max)

  erb(:random_results)
end
