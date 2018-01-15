#!/usr/bin/env bash

 docker run -it --network devmode_devmode \
                -e GOPATH=/opt/gopath \
                -e CORE_VM_ENDPOINT=unix:///host/var/run/docker.sock \
                -e CORE_LOGGING_LEVEL=DEBUG \
                -e CORE_PEER_ID=cli \
                -e CORE_PEER_ADDRESS=peer:7051 \
                -e CORE_PEER_LOCALMSPID=DEFAULT \
                -e CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp \
                -v /var/run/:/host/var/run/ \
                -v ../../msp:/etc/hyperledger/msp \
                -v ../../bin:/var/chaincode hyperledger/ \
                --name cli fabric-tools:x86_64-1.1.0-preview bash