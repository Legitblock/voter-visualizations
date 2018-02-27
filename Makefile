all: VoterRegOpenData.csv run_jupyter

VoterRegOpenData.csv:
	unzip VoterRegOpenDataCSV.zip
	sed -i -e '1,10d' VoterRegOpenData.csv
	iconv -f ISO-8859-1 -t UTF-8//TRANSLIT VoterRegOpenData.csv -o VoterRegOpenData.csv.out
	mv VoterRegOpenData.csv.out VoterRegOpenData.csv 

run_jupyter:
	jupyter notebook

anaconda: Anaconda3-5.0.1-Linux-x86_64.sh
	bash Anaconda3-5.0.1-Linux-x86_64.sh

Anaconda3-5.0.1-Linux-x86_64.sh:
	wget https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh

yum:
	yum install -y epel-release
	yum install -y whois traceroute nmap-ncat ansible \
		geoip-bin GeoIP GeoIP-data GeoIP-update python-GeoIP \
		bind-utils vim parallel

apt:
	apt install -y whois traceroute netcat-openbsd ansible \
		geoip-bin geoip-database python3-geoip\
	       	parallel dnsutils net-tools vim 

geoipdata:
	$(eval TMP := $(shell mktemp -d --suffix=TMP))
	cd $(TMP) \
 	&& wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz \
	&& wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz \
	&& wget http://download.maxmind.com/download/geoip/database/asnum/GeoIPASNum.dat.gz \
	&& gunzip GeoIP.dat.gz \
	&& gunzip GeoIPASNum.dat.gz \
	&& gunzip GeoLiteCity.dat.gz \
	&& sudo mv GeoIP.dat GeoIPASNum.dat GeoLiteCity.dat /usr/share/GeoIP/
	rm -Rf $(TMP)

theme:
	pip install jupyter-themer
	jupyter-themer -b dark -c midnight
