#require 'watir-webdriver'
require 'rubygems'
require 'httpclient'
require 'httparty'
require 'henry/environment'
require 'json'
require 'byebug'
require 'net/http'
require 'uri'
require 'timeout'
require 'rest_client'
require 'open-uri'
require 'byebug'
require 'minitest'
require 'rake'


begin
  HENRY_PARAMS = Henry::Environment.params
  $ENV = HENRY_PARAMS['env'] || "beta"  
  $logger = Henry::Environment.logger
  $XVERSION= HENRY_PARAMS['xversion'] || "ss-login=ss-login-beta|ds-fnx-java=ds-fnx-b-java|ss-ds=ss-ds-b|ds-fnx-java=ds-fnx-b-java|tickets-resources=beta|tickets-disney=beta|tickets-universal=beta|ds-shopping=beta|ds-chas=beta|ds-checkout=beta|ds-bkr=beta|ds-sm=beta|ds-dbs=beta|ds-pam=beta|ds-bo=beta|tickets-resources=beta|activities=beta|ds-dbs=beta|ds-sm=beta|ds-bkr=beta|ds-pam=beta|ds-bo=beta|ds-cassandra=beta|activities-summaries=beta|ss-login=ss-login-beta|ds-fnx-java=ds-fnx-b-java|ss-ds=ss-ds-b|ds-fnx-java=ds-fnx-b-java|tickets-resources=beta|tickets-disney=beta|tickets-universal=beta|ds-shopping=beta|ds-chas=beta|ds-checkout=beta|ds-bkr=beta|ds-sm=beta|ds-dbs=beta|ds-pam=beta|ds-bo=beta|tickets-resources=beta|activities=beta|ds-dbs=beta|ds-sm=beta|ds-bkr=beta|ds-pam=beta|ds-bo=beta|ds-cassandra=beta|activities-summaries=beta|ss-ds-adv=ss-ds-b|ss-ds-static=ss-ds-static-b|ds-fnx-node=ds-fnx-b-node|ds-fnx-static=ds-fnx-b-node|ds-assistance=beta"
  #$XVERSION= HENRY_PARAMS['xversion'] || "ds-dbs=beta|ds-sm=beta"
  $XUSER="12363"
  $RCUSER="1814"
rescue
  $ENV = "rc"
end

#if (HENRY_PARAMS['env'].nil?)
#  @navegador = [:firefox, :chrome].sample

 # client = Selenium::WebDriver::Remote::Http::Default.new
 # client.timeout = 180

 # BROWSER = Watir::Browser.new @navegador, :http_client => client
 # BROWSER.cookies.clear

 # at_exit do
 #   BROWSER.close
 # end
#end