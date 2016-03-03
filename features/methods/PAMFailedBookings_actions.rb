def pam_failed_bookings
	# Consulta el servicio de Bookings Fallidos de PAMFailedBookings
	# PROD: 10.2.7.16
	# RC: 10.254.168.100

	@service = HTTParty.get("http://10.2.7.16/ds-pam/service/failedBooking/findAll")
end


def checkear_respuesta
	# Checkea la respuesta del servicio para ver si hay o no bookings fallidos

	@contenido

	if @service.nil? or @service.empty? or @service.include? "Error"
		puts "Hubo un error al consultar el servicio de Bookings Fallidos de PAM".on_red
		resultado = false
	end

	items = []

	if !@service['data'].empty? 

		@service['data'].each do | item |

			items << item['crmId']

		end

		items = items.uniq

		puts "Hay #{items.size} reserva(s) fallidas en PAM"

		puts items

		@items = items

		resultado = false

	else

		puts 'No hay reservas fallidas en PAM'

	end

	resultado

end

def enviar_alerta
	#Envia un email de alerta cuando se registran nuevos bookings fallidos

	semaphore = HTTParty.get("http://henry.despegar.com/api/monitoring/semaphores/status/55ca5f49e4b09c07e3b554cb")
	execution = HTTParty.get("http://henry.despegar.com/api/executions/stats/55ca5600e4b09c07e3b554c7")

	run_id = (execution['data']['runs'].to_a.size - 1)

	last_execution = execution['data']['runs'][run_id]['executionInstanceId']
	result = HTTParty.get("http://henry.despegar.com/api/results/#{last_execution}")

	last_items = result['data'][0]['result']['tasks'][0][0]['returnedData']['output'][/\[(.*?)\]/, 1 ]

	if semaphore['data']['statusHolder']['status']['status'] == 'ERROR' 

		if last_items.length < @items.to_s[/\[(.*?)\]/, 1 ].length

			body_template = '<br><h2># Servicio de alerta de bookings fallidos de DS-PAM #</h2><br><b>Existen nuevas reservas fallidas / pendientes de emisión:</b><br><ul>'

			@items.each do | item |
				body_template = body_template + '<li>' + item.to_s + '</li>'
			end

			body_template = body_template + '</ul>'


			mail = Mail.new do
				from 'ds.test.alert@gmail.com'
				to 'smendoza@despegar.com, ds-pam@despegar.com'
				subject 'Nuevas reservas fallidas de DS-PAM'

				html_part do
			    	content_type 'text/html; charset=UTF-8'
 			   		body body_template
				end
			end

			mail.deliver!
		end
	end
	false
end

