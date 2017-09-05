
# A selection of tests to smoke-test a site
task :'smoke', [:key] => :environment do |taskname, args|
  Visitor.all
  puts "Smoke tests - PASS"
end
