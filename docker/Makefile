CONTAINER=opensearch

run:
	docker run -p 9200:9200 \
		-p 9600:9600 \
		-e "discovery.type=single-node" \
		-e "DISABLE_SECURITY_PLUGIN"=true \
		--name $(CONTAINER) \
		-d \
		opensearchproject/opensearch:1.2.4

rm:
	docker rm -f $(CONTAINER)
