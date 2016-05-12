 def take_grupoficha
 	@service= HTTParty.get("http://10.2.7.16/ds-rm/service/group-records", :headers =>{'X-UOW' => 'Pollo-BOT'})
 end

 def update_grupoficha

 	if @service.nil? or @service.empty? or @service.include? "Error"
 		puts "Hubo un error en la consulta del servicio group-records".on_red
 		resultado=false
 	end
  	BROWSER.goto("http://backoffice.despegar.com/ds-rambo/login")
 	BROWSER.text_field(:name => "j_username").set "jdelrio.ar"
 	BROWSER.text_field(:name => "j_password").set "Pollo446"
 	BROWSER.button(:class, 'btn btn-success').click
 	Watir::Wait.until {BROWSER.ready_state == 'complete'}
  	count= 0
  	@service.each do | group |
  		puts group ['oid']
  		count= count + 1
  		@url= "http://backoffice.despegar.com/ds-rambo/#!/group-records/edit/" + group['oid']
  		BROWSER.goto(@url)
  		sleep 5

  		while !BROWSER.button(:class,'btn btn-lg btn-danger').present? do
  			BROWSER.goto(@url)
  			sleep 5
  		end
  		#BROWSER.button(:class,'btn btn-lg btn-danger').wait_until_present
 		#Watir::Wait.until {BROWSER.ready_state == "complete"}
 		#sleep 5
 		BROWSER.scroll.to :bottom
 		BROWSER.button(:class,'btn btn-lg btn-primary ng-binding').click
 		sleep 5

 	end
 	puts= count

 end

