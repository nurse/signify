SUBDIRS = src

TESTS_ENVIRONMENT = env PATH="src:${PATH}" srcdir=${srcdir}/test
TESTS = test/signify.sh
EXTRA_DIST = test/forgery.txt.sig test/orders.txt.sig test/regresskey.sec \
	test/forgery.txt test/orders.txt test/regresskey.pub test/signify.sh
