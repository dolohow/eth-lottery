// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.4;

contract Lottery {
    address public owner;

    event Payout(address indexed _from, uint256 indexed _balance);

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {
        require(msg.value > 0 ether, "You cannot send 0 eth");
        if (isLucky()) {
            payable(msg.sender).transfer(address(this).balance);
            emit Payout(msg.sender, address(this).balance);
        }
    }

    function isLucky() private view returns (bool ok) {
        // not sure if random enough
        uint256 random =
            uint256(
                keccak256(
                    abi.encodePacked(
                        block.timestamp,
                        block.difficulty,
                        msg.sender
                    )
                )
            );
        return random % 100 < 1;
    }
}
