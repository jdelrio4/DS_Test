# -*- encoding : utf-8 -*-
#language: es
Dado(/^que invoco al servicio de group\-records$/) do
	@navegador = [:chrome].sample
  	client = Selenium::WebDriver::Remote::Http::Default.new
  	client.timeout = 360
  	BROWSER = Watir::Browser.new @navegador, :http_client => client
  	BROWSER.headers
  	BROWSER.cookies.clear
  	BROWSER.window.maximize
  	at_exit do
    	BROWSER.close
  	end

	take_grupoficha
end

Entonces(/^tomo cada oid y actualizo cada grupo de ficha$/) do
  update_grupoficha
end
