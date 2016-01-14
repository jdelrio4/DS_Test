# -*- encoding : utf-8 -*-
#language: es
Dado(/^que invoco al servicio de bookings fallidos de PAM$/) do
  pam_failed_bookings
 end

Entonces(/^checkeo si hay bookings fallidos$/) do
  checkear_respuesta.should be_truthy
end