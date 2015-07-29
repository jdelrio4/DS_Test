#language: es

@quotamedia
	
	Característica: Verificar la mediante servicio la quota de media, de este modo poder realizar una alarma cuando se llegue al límite

	Escenario:Invocar el servicio de quota media validando que el valor de used sea inferior al de total.
	Dado que invoco al servicio de quota de media 
	Entonces verifico el estado de la quota

