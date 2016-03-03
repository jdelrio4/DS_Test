# -*- encoding : utf-8 -*-
#language: es
Dado(/^que invoco al servicio de listado de Bundles de RM$/) do
  rm_bundle_list
 end

Entonces(/^checkeo si cada item que los compone tiene disponibilidad$/) do
  resultado = checkear_bundles
  ##resultado.should be_truthy
  if !resultado
  	alerta_bundles
  end
end