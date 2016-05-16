def pam_failed_bookings
	# Consulta el servicio de Bookings Fallidos de PAMFailedBookings
	# PROD: 10.2.7.16
	# RC: 10.254.168.100
	@ip = '10.2.7.16'
	@service = HTTParty.get("http://#{@ip}/ds-pam/service/failedBooking/findAll", :headers =>{'X-UOW' => 'GUIDO-BOT'})
end


def checkear_respuesta
	# Checkea la respuesta del servicio para ver si hay o no bookings fallidos

	@contenido

	if @service.nil? or @service.empty? or @service.include? "Error"

		puts "Hubo un error al consultar el servicio de Bookings Fallidos de PAM".on_red
		resultado = true
	end

	@items = []
	@left_items = []
	@done_items = []

	if !@service['data'].empty? 

		@service['data'].each do | item |

			if !@items.empty?

				next if @items.to_s.include?(item['crmId'].to_s)
			end

			if item['bookingServiceType'] == 'ACTIVITY'

				service_type = 'tours'
			else

				service_type = 'transfers'
			end

			fenix_stat = HTTParty.get("http://#{@ip}/fenix/ds/#{service_type}?transaction_id=#{item['crmId']}", :headers =>{'X-UOW' => 'GUIDO-BOT'})

			if fenix_stat['items'][0]['home_status']['code'].to_s == 'DONE'

				@done_items << item['crmId'].to_s + ' (Emitida)'

			elsif fenix_stat['items'][0]['home_status']['code'].to_s == 'CANCELED'

				@done_items << item['crmId'].to_s + ' (Cancelada)'

			else

				@left_items << item['crmId']
			end

			@items << item['crmId']

		end	
	end

	if !@items.empty?

		puts "Hay #{@items.size} reserva(s) fallida(s) en PAM:"

		puts @items

		if !@left_items.empty?

			puts "Hay #{@left_items.size} reserva(s) pendiente(s):"

			puts @left_items
		end

		if !@done_items.empty?

			puts "Hay #{@done_items.size} reserva(s) que ya ha(n) sido resuelta(s):"

			puts @done_items
		end

		resultado = false
	else

		resultado = true

		puts 'No hay reservas fallidas en PAM'
	end

	
	resultado
end

def nuevos_bookings

	body_template = '<br><h2># Servicio de alerta de bookings fallidos de DS-PAM #</h2><br><b>Reservas fallidas / pendientes de emisión:</b><br><ul>'

			if !@left_items.empty?
			
				@left_items.each do | left |
					body_template = body_template + '<li>' + left.to_s + '</li>'
				end
			else
				body_template = body_template + 'No hay reservas pendientes'
			end

			body_template = body_template + '</ul><br><br><b>Reservas fallidas en PAM que ya han sido resueltas:</b><br><ul>'

			@done_items.each do | done |
				body_template = body_template + '<li>' + done.to_s + '</li>'
			end

			body_template = body_template + '<br><br><br><br><br>-Reporte automatizado de DS-QA<br>Dudas o consultas: ds-qa@despegar.com'

			mail = Mail.new do
				from 'ds.test.alert@gmail.com'
				to 'ds-pam@despegar.com, nmelano@despegar.com, reservastkts@despegar.com, ddileo@despegar.com'
				subject '[Alerta] Reservas fallidas en DS-PAM - DS Automation'

				html_part do
			    	content_type 'text/html; charset=UTF-8'
 			   		body body_template
				end
			end

	mail.deliver!
end

def enviar_alerta
	#Envia un email de alerta cuando se registran nuevos bookings fallidos

	semaphore = HTTParty.get("http://backend-cross.despexds.net/henry-prod-service/monitoring/semaphores/status/55ca5f49e4b09c07e3b554cb")
	execution = HTTParty.get("http://backend-cross.despexds.net/henry-prod-service/executions/stats/55ca5600e4b09c07e3b554c7")

	run_id = (execution['data']['runs'].to_a.size - 1)

	last_execution = execution['data']['runs'][run_id]['executionInstanceId']
	result = HTTParty.get("http://backend-cross.despexds.net/henry-prod-service/results/#{last_execution}")

	last_items = result['data'][0]['result']['tasks'][0][0]['returnedData']['output'][/\[(.*?)\]/, 1]

	if semaphore['data']['statusHolder']['status']['status'] == 'ERROR' 

		if last_items.to_s.length < @items.to_s[/\[(.*?)\]/, 1 ].length

			nuevos_bookings
		end
	else
		nuevos_bookings
	end

	false
end