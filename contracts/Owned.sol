pragma solidity ^0.4.15;

contract Owned {
	function Owned() { owner = msg.sender; }
	address owner;
	
	modifier ensureOwned {
		require(msg.sender == owner);
		_;
	}
	
	function resetOwner() ensureOwned {
		owner = msg.sender;
	}
	
	function kill() ensureOwned {
		selfdestruct(owner);
	}
}
