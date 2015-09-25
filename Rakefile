# -*- encoding : utf-8 -*-
#language: es

require "bundler/gem_tasks"
require "cucumber/rake/task"

t = Time.now.strftime("%d%m%Y%H%M")
parametros = "features --format pretty --format html --out"

Cucumber::Rake::Task.new(:quotamedia) do |task|
  task.cucumber_opts = ["#{parametros} log/quotamedia#{t}.html --tags @quota_media"] 
end

<<<<<<< HEAD
Cucumber::Rake::Task.new(:PAMFailedBookings) do |task|
=======
Cucumber::Rake::Task.new(:pam_failed_bookings) do |task|
>>>>>>> 45cd5739ee220a060f58cac52efde83b5fa49f10
  task.cucumber_opts = ["#{parametros} log/PAMFailedBookings#{t}.html --tags @pam_failed_bookings"] 
end