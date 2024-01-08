all: dist/download-stream.min.js dist/ecdssw.min.js

dist/%.min.js: dist/%.js node_modules/.bin/uglifyjs
	./node_modules/.bin/uglifyjs -m --comments '/^!|SPDX/' < $< > $@

dist/download-stream.js: src/download-stream.js
	mkdir -p dist
	./browserify-build.js > $@

dist/ecdssw.js: src/download-stream.js
	cp src/service-worker.js $@

src/download-stream.js: src/*.ts node_modules/.bin/uglifyjs
	./node_modules/.bin/tsc

node_modules/.bin/uglifyjs:
	npm install

clean:
	rm -f src/*.js
	rm -rf dist
