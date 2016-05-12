# -*- encoding : utf-8 -*-
#language: es

require "bundler/gem_tasks"
require "cucumber/rake/task"

t = Time.now.strftime("%d%m%Y%H%M")
parametros = "features --format pretty --format html --out"

Cucumber::Rake::Task.new(:quotamedia) do |task|
  task.cucumber_opts = ["#{parametros} log/quotamedia#{t}.html --tags @quota_media"] 
end

Cucumber::Rake::Task.new(:PAMFailedBookings) do |task|
  task.cucumber_opts = ["#{parametros} log/PAMFailedBookings#{t}.html --tags @pam_failed_bookings"] 
end

Cucumber::Rake::Task.new(:RMBundleStatus) do |task|
  task.cucumber_opts = ["#{parametros} log/RMBundleStatus#{t}.html --tags @rm_bundle_status"]
end

Cucumber::Rake::Task.new(:RMupdategrupoficha) do |task|
  task.cucumber_opts = ["#{parametros} log/RMupdategrupoficha#{t}.html --tags @update_grupoficha"]
end