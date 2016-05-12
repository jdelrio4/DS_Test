# -*- encoding : utf-8 -*-
#language: es
Dado(/^que invoco al servicio de Grupos de Fichas de RM$/) do
	rm_group_records
end

Entonces(/^checkeo aquellos grupos con orden Automatico que contengan actividades de PAM y en la competencia de costos gane alguna otra actividad de otro proveedor$/) do

	if checkear_orden
		alerta_group_records
	end
end