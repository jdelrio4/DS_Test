#language: es

@pam_failed_bookings
	
	Característica: Consultar el servicio de bookings fallidos de PAM para ver si existe alguno y generar una alarma para alertar de la situación.

	Escenario: Invocar el servicio de bookings fallidos de PAM validando que existan o no entradas.


	Dado que invoco al servicio de bookings fallidos de PAM
	Entonces checkeo si hay bookings fallidos