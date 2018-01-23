#!/usr/bin/env bash

 docker run --rm -it --name cli \
                --network devmode_devmode \
                -e GOPATH=/opt/gopath \
                -e CORE_VM_ENDPOINT=unix:///host/var/run/docker.sock \
                -e CORE_LOGGING_LEVEL=DEBUG \
                -e CORE_PEER_ID=cli \
                -e CORE_PEER_ADDRESS=peer:7051 \
                -e CORE_PEER_LOCALMSPID=DEFAULT \
                -e CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp \
                -v /var/run/:/host/var/run/ \
                -v /C/Users/bolek.tekielski/Documents/Development/go/fabric-exercises/msp:/etc/hyperledger/msp \
                -v /C/Users/bolek.tekielski/Documents/Development/go/fabric-exercises/bin:/var/chaincode \
                -v /C/Users/bolek.tekielski/Documents/Development/go/fabric-exercises/crypto:/etc/hyperledger/crypto \
                -w /etc/hyperledger hyperledger/fabric-tools:x86_64-1.1.0-preview bash


#   docker run -it --network devmode_devmode -e GOPATH=/opt/gopath -e CORE_VM_ENDPOINT=unix:///host/var/run/docker.sock -e CORE_LOGGING_LEVEL=DEBUG -e CORE_PEER_ID=cli -e CORE_PEER_ADDRESS=peer:7051 -e CORE_PEER_LOCALMSPID=DEFAULT -e CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp -v /var/run/:/host/var/run/ -v ///C/Users/bolek.tekielski/Documents/Development/go/fabric-exercises/msp:/etc/hyperledger/msp -v ///C/Users/bolek.tekielski/Documents/Development/go/fabric-exercises/bin:/var/chaincode --name cli hyperledger/fabric-tools:x86_64-1.1.0-preview bash