#language: es

@update_grupoficha
	
	Característica: Consultar el servicio de Rambo de grupo de fichas y utilizando cada oid actualizar las fichas

	Escenario: Tomar del servicio de grupo de fichas de rambo los oids y actualizar cada grupo


	Dado que invoco al servicio de group-records 
	Entonces tomo cada oid y actualizo cada grupo de ficha