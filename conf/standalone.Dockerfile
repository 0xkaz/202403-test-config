FROM amd64/node:18.19-alpine
COPY ./ /weavedb/grpc-node/node-server
COPY ./weavedb.standalone.config.tmpl.js /weavedb/grpc-node/node-server/weavedb.standalone.config.tmpl.js
WORKDIR /weavedb/grpc-node/node-server
RUN yarn
EXPOSE 9090
RUN chmod +x /weavedb/grpc-node/node-server/*.sh
RUN /weavedb/grpc-node/node-server/setup-node-starndalone.sh
ENTRYPOINT ["/weavedb/grpc-node/node-server/start-node-starndalone.sh"]