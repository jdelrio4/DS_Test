# -*- encoding : utf-8 -*-
#language: es
Dado(/^que invoco al servicio de quota de media$/) do
  quota_media
end

Entonces(/^verifico el estado de la quota$/) do
	expect(validar_media).to be_truthy
end