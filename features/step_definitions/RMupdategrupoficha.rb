# -*- encoding : utf-8 -*-
#language: es
Dado(/^que invoco al servicio de group\-records$/) do
  take_grupoficha
end

Entonces(/^tomo cada oid y actualizo cada grupo de ficha$/) do
  update_grupoficha
end
