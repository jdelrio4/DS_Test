def rm_bundle_list
	# Consulta el servicio de RM que devuelve el listado de Bundles y los items que los componen.
	# PROD: 10.2.7.16
	# RC: 10.254.168.100
	@ip = '10.2.7.16'
	@bundles = HTTParty.get("http://#{@ip}/ds-rm/service/bundles", :headers =>{'X-UOW' => 'GUIDO-BOT'})
end


def checkear_bundles
	#Checkea la disponibilidad de cada uno de los items que componen los bundles cargados.

	if @bundles.nil? or @bundles.empty? or @bundles.include? "error"
		puts "Hubo un error al consultar el servicio de Bundles de RM".on_red
		checkeado = false
	end

	bundle_info = []
	to_print = []

	if !@bundles.empty?

		@bundles.each do | check |

			check['items'].each do | availability |

				tracking_id = availability['trackingId'].gsub ' ', '%20'

				i = 0
				for i in 0..1 do

					record = HTTParty.get("http://#{@ip}/ds-rm/service/provider-records?tracking_id=#{tracking_id}", :headers =>{'X-UOW' => 'GUIDO-BOT'})

					if record.nil? or record.empty? or record.include? 'errors'

						i = i + 1
						if i == 2
							
							rambo_ref = '<A HREF="http://backoffice.despegar.com/ds-rambo/#!/bundle/edition/' + check['oid'] + '">Editar en RAMBO</A><br><br>'

							bundle_title = check['title']['es']
							bundle_oid = check['oid']
							bundle_info << bundle_title + ' | oid: ' + bundle_oid + '<br>' + rambo_ref
							to_print << bundle_title + ' | oid: ' + bundle_oid
						end
					else
						i = 2
					end
				end
			end
		end
	end

	if !bundle_info.empty?

		@output = bundle_info.uniq
		to_print = to_print.uniq
		puts to_print
		false
	else

		puts 'Todos los bundles cargados tienen disponibilidad.'
	end
end


def alerta_bundles
	#Genera y envía un e-mail de alerta listando los bundles que contengan items sin disponibilidad.

	body_template = '<br><h1># Servicio de alerta de Bundles con items sin disponibilidad: #</h1><br><b>Los siguientes Bundles no se estan ofreciendo en el sitio
	porque uno o más de los items que los componen no estan disponibles:</b><br><ul>'

			@output.each do | item |
				body_template = body_template + '<li>' + item.to_s + '</li>'
			end

			body_template = body_template + '</ul>' + '<br><br><br><br><br><h3>Para editar los Bundles dirigirse a DS-RAMBO:</h3><br>
			<a href="http://backoffice.despegar.com/ds-rambo/login">
 			<img src="http://www.despegar.com/media/pictures/dcba67fc-0775-48d9-b00d-27b8f296af43" alt="Mountain View" style="width:320px;height:85px;">
			</a><br><br><br><br><br>
			-Reporte automatizado de DS-QA<br>
			Dudas o consultas: ds-qa@despegar.com'

			mail = Mail.new do
				from 'ds.test.alert@gmail.com'
				#to  'smendoza@despegar.com, ds-shopping@despegar.com, dssales-product@despegar.com, nicolas.sacheri@despegar.com, santiago.iribarne@despegar.com'
			    to  'sochoa@despegar.com, nicolas.sacheri@despegar.com'
				subject '[Alerta] Bundles con items sin disponibilidad - DS Automation'

				html_part do
			    	content_type 'text/html; charset=UTF-8'
 			   		body body_template
				end
			end

	mail.deliver!
end