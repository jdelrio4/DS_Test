#language: es

@rm_bundle_status
	
	Característica: Consultar el servicio de listado de Bundles de RM para ver si esta activo y checkear la disponibilidad de los items que los componen.

	Escenario: Invocar el servicio de listado de Bundles de RM validando que existan bundles y tengan disponibilidad real.


	Dado que invoco al servicio de listado de Bundles de RM
	Entonces checkeo si cada item que los compone tiene disponibilidad