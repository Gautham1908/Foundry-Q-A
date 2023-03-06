// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Question3 {
    mapping(uint256 => address) private ownerOf;

    constructor() {
        ownerOf[0] = address(1);
        ownerOf[1] = address(2);
        ownerOf[2] = address(3);
        ownerOf[3] = address(4);
        ownerOf[4] = address(5);
    }

    function readOwnerOf(uint256 tokenId) external view returns (address) {
        // Read the mapping value without calling ownerOf[tokenId]
        return
            ownerOf[
                tokenId &
                    0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            ];
    }
}

// In the readOwnerOf function, we're using a bitwise AND operation to extract the lower 256 bits of
// tokenId (since the Solidity compiler automatically truncates the input to the appropriate length),
// and then using that as the key to look up the corresponding value in the ownerOf mapping.
// This allows us to read the mapping value without directly accessing it with the ownerOf[tokenId] syntax,
// which is useful for certain scenarios where direct access is not possible or desirable.