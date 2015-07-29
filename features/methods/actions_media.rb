def quotamedia
	#consulta el estado de la quota de media
	
	@service = HTTParty.get("http://backoffice.despegar.com/media/quotas/DS")
end


def validar_media
	#valida que no se este llegando al limite disponible en media

	 if @service.nil? or @service.empty? or @service.include? "Error"
		puts "Hubo un error en la consulta de la quota de media".on_red
		resultado=false
  end

  total = @service['data']['total']
  used = @service['data']['used']

  left = total - used

  if left < 2000
		puts "Estamos #{left} por llegar al límite"
		resultado=false
	else 
		puts "Todo bien"
	end
end