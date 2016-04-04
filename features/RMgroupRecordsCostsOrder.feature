#language: es

@rm_group_records_costs_order
	
	Característica: Consultar el servicio de Grupos de Fichas de RM para ver si existe alguno que tenga orden automático, contenga al menos una actividad de PAM y que la actividad ganadora segun los costos sea de un proveedor distinto de PAM.

	Escenario: Invocar el servicio de grupos de fichas de RM y reportar aquellos grupos con orden automático que contengan actividades de PAM que no ganen la competencia de costos.

	Dado que invoco al servicio de Grupos de Fichas de RM

	Entonces checkeo aquellos grupos con orden Automatico que contengan actividades de PAM y en la competencia de costos gane alguna otra actividad de otro proveedor