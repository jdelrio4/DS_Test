# -*- encoding : utf-8 -*-
#language: es
Dado(/^que invoco al servicio de quota de media$/) do
  quota_media
end

Entonces(/^verifico el estado de la quota$/) do
	validar_media.should be_truthy
end