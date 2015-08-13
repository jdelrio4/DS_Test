def pam_failed_bookings
	# Consulta el servicio de Bookings Fallidos de PAMFailedBookings
	# PROD: 10.2.7.16
	# RC: 10.254.168.100

	@service = HTTParty.get("http://10.2.7.16/ds-pam/service/failedBooking/findAll")
end


def checkear_respuesta
	# Checkea la respuesta del servicio para ver si hay o no bookings fallidos

	if @service.nil? or @service.empty? or @service.include? "Error"
		puts "Hubo un error al consultar el servicio de Bookings Fallidos de PAM".on_red
		resultado=false
	end

	items = []

	if !@service['data'].empty? 

		@service['data'].each do | item |

			items << item['crmId']

		end

		items = items.uniq

		puts "Hay #{items.size} reserva(s) fallidas en PAM"

		puts items

		resultado = false

	else

		puts 'No hay reservas fallidas en PAM'
	
	end


end