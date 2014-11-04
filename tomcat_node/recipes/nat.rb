include_recipe "simple_iptables"

# Tomcat redirects
simple_iptables_rule "tomcat" do
  table "nat"
  direction "PREROUTING"
  rule [ "--protocol tcp --dport 80 --jump REDIRECT --to-port 8080",
         "--protocol tcp --dport 443 --jump REDIRECT --to-port 8443" ]
  jump false
end

application 'my-app' do
  path         '/usr/local/admin'
  repository   'https://s3-eu-west-1.amazonaws.com/tl-app-versions/TL-ROOT.war?X-Amz-Date=20141104T163256Z&X-Amz-Expires=300&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Signature=fd86842115535c61a7ec69c08542a917b9031b072eac8bc146aa988341de8bdc&X-Amz-Credential=ASIAIEWRKWMKOID6WBPA/20141104/eu-west-1/s3/aws4_request&X-Amz-SignedHeaders=Host&x-amz-security-token=AQoDYXdzEKn//////////wEagAJOteQhLHtuIrmaUVa1dFlbNz3%2BjLiy/8MKvw%2Bp%2BU2uMx6o4Io6PBn2WomQjcDCqlByOwmnrA0EKbV7LOFWTs6YZRrdA%2B%2BoE8KLI9JJ1vJPOj0cp19RpzPXRAUQ8rHRF8DDy0%2BptXytb1ScVj7PusxBNIOGj2CDBqnISLB7vQvzamkNctDwFG32r/hMu37sP3BbXpxBU/t%2BbnOHKoVvl3H01OIBySVninF/hnbYy6et9neU7hZ1VZpETjg42YuqPD2B40EpS9tonsB58z0H3AinxpkGNjwaImbkLCyvxT6oQbigduJ04X1FMP5kIEZSNTRf4a5UkKYkGXBw3yzh4TQ2INyl4qIF'
  revision     '1.0'
  scm_provider Chef::Provider::File::Deploy

  tomcat
end