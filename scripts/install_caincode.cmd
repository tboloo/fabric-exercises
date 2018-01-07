peer chaincode install -p chaincodedev/chaincode/chaincode_example02 -n mycc -v 0
peer chaincode instantiate -n mycc -v 0 -c '{"Args":["init","a","100","b","200"]}' -C myc