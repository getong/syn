PROJECT_DIR:=$(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))

all:
	@rebar3 compile

clean:
	@rebar3 clean
	@find $(PROJECT_DIR)/. -name "erl_crash\.dump" | xargs rm -f

dialyze:
	@rebar3 dialyzer

run:
	@erl -pa `rebar3 path` \
	-name syn@127.0.0.1 \
	+K true \
	-mnesia schema_location ram \
	-eval 'syn:start(),syn:init().'

test: all
	@$(PROJECT_DIR)/rebar3 ct

travis:
	@$(PROJECT_DIR)/rebar3 compile
	@$(PROJECT_DIR)/rebar3 ct
