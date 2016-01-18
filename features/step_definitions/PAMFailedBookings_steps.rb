# -*- encoding : utf-8 -*-
#language: es
Dado(/^que invoco al servicio de bookings fallidos de PAM$/) do
  pam_failed_bookings
 end

Entonces(/^checkeo si hay bookings fallidos$/) do
  resultado = checkear_respuesta
  ##resultado.should be_truthy
  if !resultado
  	enviar_alerta
  end
end