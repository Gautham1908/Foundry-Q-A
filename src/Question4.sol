
// //pragma solidity ^0.8.13;

// contract Question4 {
//     bytes32 public domainSeparator;

//     struct SellOrder {
//         address signer;
//         address collection;
//         uint256 id;
//         uint256 price;
//     }

//     // TODO: Come up with the typehash
//     bytes32 public constant SELL_ORDER_TYPEHASH = bytes32(0);

//     constructor() {
//         // TODO: Come up with the domain separator
//         domainSeparator = bytes32(0);
//     }

//     function buy(
//         SellOrder calldata sellOrder,
//         uint8 v,
//         bytes32 r,
//         bytes32 s
//     ) external payable {
//         /**
//          * TODO:
//          * 1. Verify the signer actually signed the order
//          * 2. Transfer the NFT to the taker
//          * 3. Transfer the ETH to the maker
//          */
//     }

//     function sellOrderDigest(SellOrder calldata sellOrder)
//         public
//         pure
//         returns (bytes32)
//     {
//         // TODO: Come up with the sell order digest
//     }
// }

// SPDX-License-Identifier: MIT
import "../lib/openzeppelin-contracts/contracts/interfaces/IERC721.sol";

pragma solidity ^0.8.13;

contract Question4 {
    bytes32 public domainSeparator;

    struct SellOrder {
        address signer;
        address collection;
        uint256 id;
        uint256 price;
    }

    // TODO: Define the SELL_ORDER_TYPEHASH
    bytes32 public constant SELL_ORDER_TYPEHASH = keccak256("SellOrder(address signer,address collection,uint256 id,uint256 price)");

    constructor() {
        // TODO: Define the domain separator
        domainSeparator = keccak256(abi.encode(
            keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"),
            keccak256(bytes("Question4")),
            keccak256(bytes("1")),
            block.chainid,
            address(this)
        ));
    }

    function buy(
        SellOrder calldata sellOrder,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external payable {
        // Verify the signer actually signed the order
        bytes32 digest = keccak256(
            abi.encodePacked(
                "\x19\x01",
                domainSeparator,
                sellOrderDigest(sellOrder)
            )
        );
        require(sellOrder.signer == ecrecover(digest, v, r, s), "Invalid signature");

        // Transfer the NFT to the buyer
        // Assumes that the NFT is an ERC721 token
        IERC721(sellOrder.collection).transferFrom(sellOrder.signer, msg.sender, sellOrder.id);

        // Transfer the ETH to the seller
        require(msg.value == sellOrder.price, "Invalid price");
        payable(sellOrder.signer).transfer(msg.value);
    }

    function sellOrderDigest(SellOrder calldata sellOrder)
        public
        pure
        returns (bytes32)
    {
        return keccak256(abi.encode(
            SELL_ORDER_TYPEHASH,
            sellOrder.signer,
            sellOrder.collection,
            sellOrder.id,
            sellOrder.price
        ));
    }
}


// pragma solidity ^0.8.13;

// import "../lib/openzeppelin-contracts/contracts/interfaces/IERC721.sol";

// contract Question4 {
//     bytes32 public domainSeparator;

//     struct SellOrder {
//         address signer;
//         address collection;
//         uint256 id;
//         uint256 price;
//     }

//     // Come up with the typehash
//     bytes32 public constant SELL_ORDER_TYPEHASH =
//         keccak256(
//             "SellOrder(address signer,address collection,uint256 id,uint256 price)"
//         );

//     constructor() {
//         // Come up with the domain separator
//         domainSeparator = keccak256(
//             abi.encode(
//                 keccak256(
//                     "EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"
//                 ),
//                 keccak256(bytes("Question4")),
//                 keccak256(bytes("1")),
//                 block.chainid,
//                 address(this)
//             )
//         );
//     }

//     function buy(
//         SellOrder calldata sellOrder,
//         uint8 v,
//         bytes32 r,
//         bytes32 s
//     ) external payable {
//         // Verify the signer actually signed the order
//         bytes32 digest = sellOrderDigest(sellOrder);
//         address recoveredSigner = ecrecover(digest, v, r, s);
//         require(recoveredSigner == sellOrder.signer, "Invalid signature");

//         // Transfer the NFT to the taker
//         // Assumes the NFT is an ERC721 contract
//         require(msg.value == sellOrder.price, "Incorrect value sent");
//         IERC721(sellOrder.collection).transferFrom(
//             sellOrder.signer,
//             msg.sender,
//             sellOrder.id
//         );

//         // Transfer the ETH to the maker
//         payable(sellOrder.signer).transfer(msg.value);
//     }

//     function sellOrderDigest(SellOrder calldata sellOrder)
//         public
//         view
//         returns (bytes32)
//     {
//         // Come up with the sell order digest
//         return
//             keccak256(
//                 abi.encodePacked(
//                     "\x19\x01",
//                     domainSeparator,
//                     keccak256(
//                         abi.encode(
//                             SELL_ORDER_TYPEHASH,
//                             sellOrder.signer,
//                             sellOrder.collection,
//                             sellOrder.id,
//                             sellOrder.price
//                         )
//                     )
//                 )
//             );
//     }
// }

// pragma solidity ^0.8.13;

// contract Question4 {
//     bytes32 public domainSeparator;

//     struct SellOrder {
//         address signer;
//         address collection;
//         uint256 id;
//         uint256 price;
//     }

//     bytes32 public constant SELL_ORDER_TYPEHASH = keccak256("SellOrder(address signer,address collection,uint256 id,uint256 price)");

//     constructor() {
//         domainSeparator = keccak256(abi.encode(
//             keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"),
//             keccak256(bytes("Question4")),
//             keccak256(bytes("1")),
//             block.chainid,
//             address(this)
//         ));
//     }

//     function buy(SellOrder calldata sellOrder, uint8 v, bytes32 r, bytes32 s) external payable {
//         bytes32 digest = sellOrderDigest(sellOrder);
//         address signer = ecrecover(digest, v, r, s);
//         require(signer == sellOrder.signer, "Invalid signature");

//         // TODO: Transfer the NFT to the taker
//         // TODO: Transfer the ETH to the maker
//     }

//     function sellOrderDigest(SellOrder calldata sellOrder) public view returns (bytes32) {
//         return keccak256(abi.encodePacked(
//             "\x19\x01",
//             domainSeparator,
//             keccak256(abi.encode(
//                 SELL_ORDER_TYPEHASH,
//                 sellOrder.signer,
//                 sellOrder.collection,
//                 sellOrder.id,
//                 sellOrder.price
//             ))
//         ));
//     }
// }

// pragma solidity ^0.8.0;

// contract Question4 {
//     bytes32 public domainSeparator;

//     struct SellOrder {
//         address signer;
//         address collection;
//         uint256 id;
//         uint256 price;
//     }

//     bytes32 public constant SELL_ORDER_TYPEHASH = keccak256("SellOrder(address signer,address collection,uint256 id,uint256 price)");

//     constructor() {
//         domainSeparator = keccak256(abi.encode(
//             keccak256('EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)'),
//             keccak256(bytes("Question4")),
//             keccak256(bytes("1")),
//             block.chainid,
//             address(this)
//         ));
//     }

//     function buy(SellOrder calldata sellOrder, uint8 v, bytes32 r, bytes32 s) external payable {
//         bytes32 digest = keccak256(abi.encodePacked(
//             "\x19\x01",
//             domainSeparator,
//             keccak256(abi.encode(
//                 SELL_ORDER_TYPEHASH,
//                 sellOrder.signer,
//                 sellOrder.collection,
//                 sellOrder.id,
//                 sellOrder.price
//             ))
//         ));

//         address signer = ecrecover(digest, v, r, s);
//         require(signer == sellOrder.signer, "Invalid signature");

//         // TODO: Transfer the NFT to the taker
//         // TODO: Transfer the ETH to the maker
//     }

//     function sellOrderDigest(SellOrder calldata sellOrder) public view returns (bytes32) {
//         return keccak256(abi.encodePacked(
//             "\x19\x01",
//             domainSeparator,
//             keccak256(abi.encode(
//                 SELL_ORDER_TYPEHASH,
//                 sellOrder.signer,
//                 sellOrder.collection,
//                 sellOrder.id,
//                 sellOrder.price
//             ))
//         ));
//     }
// }
