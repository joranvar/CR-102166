SQLSTART ?= cd ~/git/vagrant-boxes && vagrant up
SQSH_FLAGS ?= -S localhost:1433 -U sa -P vagrant -G 7.0
TESTDIR  ?= test/

.PHONY: all
all: db test

.PHONY: db
db: bin/cr102166.db

.PHONY: test
test: test/cr102166/test.sql.success

.PHONY: expect
expect: test/cr102166/test_expect.out

vpath %.sql src test

include Makefiles/SQL.mk

# Define sut
test/cr102166/test.sql.success: src/query.sql
test/cr102166/test_expect.out: src/query.sql
