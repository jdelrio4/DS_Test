def rm_group_records
	# Consulta el servicio de Bookings Fallidos de PAMFailedBookings
	# PROD: 10.2.7.16
	# RC: 10.254.168.100
	@ip = '10.254.168.100'
	@service = HTTParty.get("http://#{@ip}/ds-rm/service/group-records", :headers =>{'X-UOW' => 'GUIDO-BOT'})

	if @service.nil? or @service.empty? or @service.include? "Error"
		puts "Hubo un error al consultar el servicio de Grupos de Fichas de RM".on_red
		resultado = false
	end

	@groups_size = @service.size.to_s

	puts "Hay #{@groups_size} grupos para la consulta"
end

def checkear_orden
	# Checkea la respuesta del servicio para ver si hay grupos con orden automático que contengan atividades de PAM donde las mismas no ganen el primer orden por Costos.

	resultado = true


	@report = []

	if !@service.empty?

		@service.each do | group |

			gname = group['name']
			costs = []
			pam_costs = []

			if group['trackingIds'].to_s.include?("PAM") && !group['useOrder']

				group['trackingIds'].each do | id |

					id = id.gsub ' ', '%20'

					url = "http://#{@ip}/ds-rm/service/provider-records?tracking_id=#{id}"

					begin

						record = HTTParty.get(url, :headers =>{'X-UOW' => 'GUIDO-BOT'},  :timeout => 60 )

					rescue Exception => e

					end

					if record.nil? or record.empty? or record.to_s.include? 'errors'

						puts "Hubo un error al consultar el servicio de Fichas de RM con el ID: #{id}".on_red
					else

						record['modalities'].each do | x |

							if id.include? "PAM" 

								pam_costs << x['adultCost'] * 1.05

							else

								costs << x['adultCost']
							end
						end
					end

					sleep 2
				end

				rambo_ref = '<A HREF="http://backoffice.despegar.com/ds-rambo/#!/group-records/edit/' + group['oid'] + '">Editar en RAMBO</A><br><br>'

				if pam_costs.nil?

						@report << group['name'] + '<br>OID: ' + group['oid'] + '<br>Destino: ' + group['destination'] + '<br>Tracking IDs:' + group['trackingIds'] + '(Actividad/es de PAM sin disponibilidad)'
				end

				if !pam_costs.min.nil? && !costs.min.nil? 

					if pam_costs.min > costs.min

						@report << group['name'].to_s + '<br>OID: ' + group['oid'] + '<br>Destino: ' + group['destination'] + '<br>Tracking IDs:' + group['trackingIds'].to_s + '<br>' + rambo_ref
					end
				end
			end
		end

		if @report.empty?

				resultado = false
		end	
	end

	resultado

	@report_size = @report.size.to_s

	puts "Hay #{@report_size} grupos de fichas donde no gana una actividad de PAM.".on_red
end



def alerta_group_records

#Genera y envía un e-mail de alerta listando los grupos de fichas con orden automático que tengan al menos una actividad de PAM pero el ganador con mejor costo sea de otro proveedor.

	body_template = "<br><h1># Servicio de alerta de Grupos de Fichas para mejora de costos PAM: #</h1><br><b>
	* Fueron consultados #{@groups_size} Grupos de Fichas.<br>
	* Aplicaron a este reporte: #{@report_size} Grupos de Fichas.</b><br><br>
	Los siguientes Grupos de Fichas contienen actividades de PAM que pierden competencia de costos con actividades de otro proveedor:<ul>"

	@report.each do | item |
		body_template = body_template + '<li>' + item.to_s + '</li>'
	end

	body_template = body_template + '</ul>' + '<br><br><br><br><br><h3>Para administrar los Grupos de Fichas dirigirse a DS-RAMBO:</h3><br>
	<a href="http://backoffice.despegar.com/ds-rambo/login">
	<img src="http://www.despegar.com/media/pictures/dcba67fc-0775-48d9-b00d-27b8f296af43" alt="Mountain View" style="width:320px;height:85px;">
	</a><br><br><br><br><br>
	-Reporte automatizado de DS-QA<br>
	Dudas o consultas: ds-qa@despegar.com'

	mail = Mail.new do
		from 'ds.test.alert@gmail.com'
		to 'smendoza@despegar.com' #'santiago.iribarne@despegar.com, nicolas.sacheri@despegar.com, ds-pam@despegar.com, nmelano@despegar.com, pscoglio@despegar.com, asaffer@despegar.com, rramires@despegar.com, mviera@despegar.com, vrico@despegar.com'
		subject '[Alerta] Grupos de Fichas con actividades PAM sin mejor costo - DS Automation'

		html_part do
			content_type 'text/html; charset=UTF-8'
			body body_template
		end
	end
	mail.deliver!
end