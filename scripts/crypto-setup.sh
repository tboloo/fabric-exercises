#!/bin/sh
#
# Copyright zeepeetek All Rights Reserved
#

usage() { echo "Usage: $0 [-c|--channel <fchannel name>] [-p|--profile <profile name>] [-o|--oraganisation-name <oraganisation name>]" 1>&2; exit 0; }

PARAMS=""
CHANNEL_NAME=mychannel
PROFILE=OneOrgOrdererGenesis
ORG_NAME=Org1MSP
CRYPTO_CONFIG=crypto-config.yaml
HELP=false

