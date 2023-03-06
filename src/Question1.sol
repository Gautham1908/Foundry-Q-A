// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Question1 {
    function iterateEachElementInArrayAndReturnTheSum(uint256[] calldata array) external pure returns (uint256 sum)
    {
        // TODO: Iterate each element in the array using only assembly
        assembly {
            // Load the length of the array
            // let len := calldataload(add(4, calldataload(4)))
            let len := array.length

            // Initialize the sum variable
            sum := 0

            // Loop over each element of the array
            for {
                let i := 0
            } lt(i, len) {
                i := add(i, 1)
            } {
                // Load the current element of the array
                let val := calldataload(add(add(4, calldataload(4)), mul(i, 32)))

                // Add the current element to the sum
                sum := add(sum, val)
            }
        }
    }
}