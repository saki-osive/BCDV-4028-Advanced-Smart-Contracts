// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// This is our initial contract
contract Storage {
    uint256 public data;

    function setData(uint256 _data) public {
        data = _data;
    }
}
// This is the caller contract
contract Caller {
    address public storageContract;

    constructor(address _storageContract) {
        storageContract = _storageContract;
    }

    function changeStorageData(uint256 _newData) public {
        // Here, we use delegatecall to change the state variable 'data' in Storage contract
        (bool success, ) = storageContract.delegatecall(
            abi.encodeWithSignature("setData(uint256)", _newData)
        );

        require(success, "Delegate call to Storage contract failed");
    }
}
