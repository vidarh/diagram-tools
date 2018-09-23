
.PHONY: clean

test-notugly.svg: test.svg ../notugly.xsl
	xsltproc ../notugly.xsl test.svg >test-notugly.svg

test.svg: test.dot
	dot -Tsvg test.dot >test.svg

clean:
	rm test.svg test-notugly.svg
