// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "../lib/forge-std/src/Test.sol";
import "../lib/forge-std/src/console.sol";
import {FungibleToken} from "./FungibleToken.sol";
import {NFT} from "./NFT.sol";

import "../src/Question1.sol";
import "../src/Question2.sol";
import "../src/Question3.sol";
import "../src/Question4.sol";
import "../src/Question5.sol";
import "../src/Question6.sol";

import "../src/Solution5.sol";
import "../src/Solution6.sol";

contract QuestionsTest is Test {
    function testQuestion1() public {
        Question1 question1 = new Question1();

        uint256[] memory array = new uint256[](5);
        array[0] = 1;
        array[1] = 2;
        array[2] = 3;
        array[3] = 4;
        array[4] = 5;

        uint256 sum = question1.iterateEachElementInArrayAndReturnTheSum(array);
        assertEq(sum, 15);
    }

    function testQuestion2() public {
        Question2 question2 = new Question2();
        assertEq(question2.readStateVariable(), 55);
    }

    function testQuestion3() public {
        Question3 question3 = new Question3();
        assertEq(question3.readOwnerOf(0), address(1));
        assertEq(question3.readOwnerOf(1), address(2));
        assertEq(question3.readOwnerOf(2), address(3));
        assertEq(question3.readOwnerOf(3), address(4));
        assertEq(question3.readOwnerOf(4), address(5));
    }

    function testQuestion4() public {
        Question4 question4 = new Question4();

        uint256 sellerPrivateKey = 0xA11CE;
        address seller = vm.addr(sellerPrivateKey);

        NFT nft = new NFT();
        uint256 id = 42;
        nft.mint(seller, id);

        Question4.SellOrder memory sellOrder = Question4.SellOrder({
            signer: seller,
            collection: address(nft),
            id: id,
            price: 1 ether
        });

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(
            sellerPrivateKey,
            keccak256(
                abi.encodePacked(
                    "\x19\x01",
                    question4.domainSeparator(),
                    question4.sellOrderDigest(sellOrder)
                )
            )
        );

        vm.prank(seller);
        nft.setApprovalForAll(address(question4), true);

        address buyer = address(888);
        vm.prank(buyer);
        vm.deal(buyer, sellOrder.price);

        question4.buy{value: sellOrder.price}(sellOrder, v, r, s);

        assertEq(nft.ownerOf(id), buyer);

        assertEq(buyer.balance, 0);
        assertEq(seller.balance, 1 ether);
    }

    function testQuestion5() public {
        Question5 question5 = new Question5();

        address victim = address(1);

        // Call the deal and prank functions on the vm object
        vm.deal(victim, 1 ether);
        vm.prank(victim);

        // Deposit 1 ether to the Question5 contract
        question5.deposit{value: 1 ether}();

        Solution5 thief = new Solution5();
        // TODO: Steal the victim's money
        // Call the exploit function of the Solution5 contract with the address of the Question5 contract
        thief.exploit{value: 1 ether}(address(question5));
        // Check that the thief's balance is now 1 ether
    }

    function testQuestion6() public {
        Question6 question6 = new Question6();
        FungibleToken erc20 = new FungibleToken();
        erc20.mint(address(question6), 1 ether);

        Solution6 thief = new Solution6();

        // TODO: Steal the contract's ERC20 tokens
        bytes memory data = abi.encodeWithSignature(
            "receiveTokens(address,address)",
            address(erc20),
            address(thief)
        );
        thief.attack(address(question6));
        question6.execute(data);
        assertEq(erc20.balanceOf(address(thief)), 1 ether);
    }

    function testQuestion7() public {
        uint256 a = 10_000;
        uint256 b = 8_000;
        uint256 c = 9_000;

        // TODO: Explain why the 2 values are not equal
        assertGt((a * b) / c, (a / c) * b);
    }

    function testQuestion8() public {
        bool a = false;
        bool b = true;

        uint256 startingGas = gasleft();
        if (a && b) {
            // Do nothing
        }
        uint256 gasSpent = startingGas - gasleft();

        uint256 startingGas2 = gasleft();
        if (a) {
            if (b) {
                // Do nothing
            }
        }
        uint256 gasSpent2 = startingGas2 - gasleft();

        // TODO: Explain why one spents more gas than the other
        assertGt(gasSpent, gasSpent2);
    }
}
