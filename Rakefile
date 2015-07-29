# -*- encoding : utf-8 -*-
#language: es

require "bundler/gem_tasks"
require "cucumber/rake/task"

t = Time.now.strftime("%d%m%Y%H%M")
parametros = "features --format pretty --format html --out"

Cucumber::Rake::Task.new(:quotamedia) do |task|
  task.cucumber_opts = ["#{parametros} log/quotamedia#{t}.html --tags @quotamedia"] 
end