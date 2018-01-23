package main

import (
	"testing"
	"github.com/hyperledger/fabric/core/chaincode/shim"
	"fmt"
)

func checkInit(t *testing.T, stub *shim.MockStub, args [][]byte) {
	res := stub.MockInit("1", args)
	if res.Status != shim.OK {
		fmt.Println("Chaincode init failed", string(res.Message))
		t.FailNow()
	}
}

func checkState(t *testing.T, stub *shim.MockStub, name string, value string) {
	bytes := stub.State[name]
	if bytes == nil {
		fmt.Println("State", name, "failed to get value")
		t.FailNow()
	}
	if string(bytes) != value {
		fmt.Println("State value", name, "was not", value, "as expected")
		t.FailNow()
	}
}

func checkInvoke(t *testing.T, stub *shim.MockStub, args [][]byte) {
	res := stub.MockInvoke("1", args)
	if res.Status != shim.OK {
		fmt.Println("Invoke", args, "failed", string(res.Message))
		t.FailNow()
	}
}

func TestSampleChaincode_Init(t *testing.T) {
	scc := new(SampleChaincode)
	stub := shim.NewMockStub("sample-chaincode", scc)
	checkInit(t, stub, [][]byte{[]byte("A"), []byte("123")})
	checkState(t, stub, "A", "123")
}

func TestSampleChaincode_SettingState(t *testing.T) {
	scc := new(SampleChaincode)
	stub := shim.NewMockStub("sample-chaincode", scc)
	checkInit(t, stub, [][]byte{[]byte("A"), []byte("123")})
	checkInvoke(t, stub, [][]byte{[]byte("set"), []byte("B"), []byte("123")})
	checkState(t, stub, "B", "123")
}

func TestSampleChaincode_GettingState(t *testing.T) {
	scc := new(SampleChaincode)
	stub := shim.NewMockStub("sample-chaincode", scc)
	checkInit(t, stub, [][]byte{[]byte("A"), []byte("123")})
	checkInvoke(t, stub, [][]byte{[]byte("get"), []byte("A")})
	checkState(t, stub, "A", "123")
}

func TestSampleChaincode_NotImplementedFunction(t *testing.T) {
	//swallow Panic
	defer func() {
		if r := recover();
		 r == nil {
			t.Errorf("The code did not panic")
		}
	}()
	scc := new(SampleChaincode)
	stub := shim.NewMockStub("sample-chaincode", scc)
	checkInvoke(t, stub, [][]byte{[]byte("some_function"), []byte("A")})
}