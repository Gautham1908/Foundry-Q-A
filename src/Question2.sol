// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Question2 {
    address private a;
    uint64 private b;
    bool private c;
    address private d;
    uint256 private e = 55;
    uint256 private f;
    address private g;

    function readStateVariable() external view returns (uint256) {
        // TODO: Read the state variable "e" using only assembly
        uint256 result;
        assembly {
            result := sload(e.slot)
        }
        return result;
    }
}