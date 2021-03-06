GIT_HASH=$(shell git rev-parse HEAD | head -c 10)
.PHONY: themes

all: travisaci

build:
	hugo

build_travis: themes
	wget https://github.com/spf13/hugo/releases/download/v0.18.1/hugo_0.18.1_Linux-64bit.tar.gz
	tar -xzf hugo_0.18.1_Linux-64bit.tar.gz
	mv hugo_0.18.1_linux_amd64/hugo_0.18.1_linux_amd64 hugo
	./hugo

themes:
	mkdir -p themes/
	git clone https://github.com/Vimux/Mainroad/
	mv Mainroad themes/mainroad
	#sed -i -e 's/e64946/5f46e6/g' themes/mainroad/static/css/style.css

localdev:
	hugo server --buildDrafts

remotedev:
	hugo server --buildDrafts --bind 192.168.1.9 --baseURL http://192.168.1.9

aci:	build
	mkdir -p stage.tmp/unixvoid_blog-layout/rootfs/cryo/data/
	mkdir -p stage.tmp/unixvoid_blog-layout/rootfs/cryo/conf/
	cp deps/manifest.json stage.tmp/unixvoid_blog-layout/manifest
	cp -R deps/nginx-filesystem/* stage.tmp/unixvoid_blog-layout/rootfs/
	wget https://cryo.unixvoid.com/bin/nginx/nginx-latest-linux-amd64
	chmod +x nginx-latest-linux-amd64
	mv nginx-latest-linux-amd64 stage.tmp/unixvoid_blog-layout/rootfs/bin/nginx
	cp deps/nginx.conf stage.tmp/unixvoid_blog-layout/rootfs/cryo/conf/
	cp deps/mime.types stage.tmp/unixvoid_blog-layout/rootfs/cryo/conf/
	cp -R public/* stage.tmp/unixvoid_blog-layout/rootfs/cryo/data/
	cd stage.tmp/ && \
		actool build unixvoid_blog-layout unixvoid_blog.aci && \
		mv unixvoid_blog.aci ../
	@echo "unixvoid_blog.aci built"

travisaci:
	mkdir -p stage.tmp/unixvoid_blog-layout/rootfs/cryo/data/
	mkdir -p stage.tmp/unixvoid_blog-layout/rootfs/cryo/conf/
	cp deps/manifest.json stage.tmp/unixvoid_blog-layout/manifest
	cp -R deps/nginx-filesystem/* stage.tmp/unixvoid_blog-layout/rootfs/
	wget https://cryo.unixvoid.com/bin/nginx/nginx-latest-linux-amd64
	chmod +x nginx-latest-linux-amd64
	mv nginx-latest-linux-amd64 stage.tmp/unixvoid_blog-layout/rootfs/bin/nginx
	cp deps/nginx.conf stage.tmp/unixvoid_blog-layout/rootfs/cryo/conf/
	cp deps/mime.types stage.tmp/unixvoid_blog-layout/rootfs/cryo/conf/
	cp -R public/* stage.tmp/unixvoid_blog-layout/rootfs/cryo/data/
	wget https://github.com/appc/spec/releases/download/v0.8.7/appc-v0.8.7.tar.gz
	tar -zxf appc-v0.8.7.tar.gz
	cd stage.tmp/ && \
		../appc-v0.8.7/actool build unixvoid_blog-layout unixvoid_blog.aci && \
		mv unixvoid_blog.aci ../
	@echo "unixvoid_blog.aci built"

travis_cp:
	mkdir target/
	cp unixvoid_blog-latest-linux-amd64.aci target/unixvoid_blog.aci
	cp deps/sign_alt.sh target/sign.sh
	chmod +x target/sign.sh
	cp unixvoid.pub target/
	cp unixvoid.sec target/
	cd target/ && \
		./sign.sh $(GPG_SEC)

clean:
	rm -rf stage.tmp/
	rm -rf public/
	rm -f unixvoid_blog.aci
