#!/bin/bash
#
# Copyright zeepeetek All Rights Reserved
#

# Exit on first error, print all commands.
set -ev

usage() { echo "Usage: $0 [-v|--version <fabric version>] [-c|--ca-version <fabric CA version>] [-i|--install-dir <install dir for platform tools>]" 1>&2; exit 0; }

PARAMS=""
VERSION=1.0.4
CA_VERSION=1.0.4
INSTALL_DIR=$PWD
HELP=false
ARCH=$(echo "$(uname -s|tr '[:upper:]' '[:lower:]'|sed 's/mingw64_nt.*/windows/')-$(uname -m | sed 's/x86_64/amd64/g')" | awk '{print tolower($0)}')
MARCH=`uname -m`

while (( "$#" )); do
  case "$1" in
    -v | --version)
      VERSION=$2
      shift 2
      ;;
    -c | --ca-version ) 
      CA_VERSION=$2
      shift 2
      ;;
    -i | --install-dir ) 
      INSTALL_DIR=$2
      shift 2
      ;;
    -h | --help )
      usage
      break;;
    --) # end argument parsing
      shift
      break
      ;;
    -*|--*=) # unsupported flags
      echo "Unsupported option $1"
      usage
      exit 1
      ;;
    # *) # preserve positional arguments
    #   PARAM="$PARAMS $1"
    #   shift
    #   ;;
  esac
done
# set positional arguments in their proper place
eval set -- "$PARAMS"

CA_TAG=$MARCH-$CA_VERSION
FABRIC_TAG=$MARCH-$VERSION

echo "Installing platform specific tools version $VERSION in directory $INSTALL_DIR/$VERSION"

mkdir -p $INSTALL_DIR/{$VERSION,bin}

if [ "$?" -ne 0 ]; then
  echo "Failed to create directory for hyperledger tools"
  exit 1
fi

curl https://nexus.hyperledger.org/content/repositories/releases/org/hyperledger/fabric/hyperledger-fabric/${ARCH}-${VERSION}/hyperledger-fabric-${ARCH}-${VERSION}.tar.gz | tar xz -C $INSTALL_DIR
ln -s $INSTALL_DIR/$VERSION/* $INSTALL_DIR/bin
export PATH=$PATH:$INSTALL_DIR/bin

echo "Pulling docker images"

docker pull hyperledger/fabric-peer:$FABRIC_TAG
docker tag hyperledger/fabric-peer:$FABRIC_TAG hyperledger/fabric-peer
docker pull hyperledger/fabric-tools:$FABRIC_TAG
docker tag hyperledger/fabric-tools:$FABRIC_TAG hyperledger/fabric-tools
# docker pull hyperledger/fabric-ca:$CA_TAG
# docker tag hyperledger/fabric-ca:$CA_TAG hyperledger/fabric-ca

