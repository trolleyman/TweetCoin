pragma solidity ^0.4.15;

import "./Owned.sol";

contract TweetCoin is Owned {
	struct Account {
		uint balance;
		bool isInitialized;
	}
	mapping (string=>Account) accounts;
	
	function TweetCoin() payable {
		
	}
	
	/**
	 * Gets the account associated with the specified account id
	 */
	function getAccount(string acctId) internal returns (Account) {
		var acct = accounts[acctId];
		if (!acct.isInitialized) {
			acct.isInitialized = true;
			acct.balance = 100000;
		}
		accounts[acctId] = acct;
		return acct;
	}
	
	/**
	 * Get the balance of the associated account
	 */
	function getBalance(string acctId) ensureOwned returns (uint) {
		var acct = getAccount(acctId);
		return acct.balance;
	}
	
	/**
	 * Transfers money from one account to another
	 * @return false if the transaction failed
	 */
	function transfer(string acctFromId, uint amount, string acctToId) ensureOwned returns (bool) {
		var acctFrom = getAccount(acctFromId);
		if (acctFrom.balance < amount)
			return false;
		
		var acctTo = getAccount(acctToId);
		acctFrom.balance -= amount;
		accounts[acctFromId] = acctFrom;
		acctTo.balance += amount;
		accounts[acctToId] = acctTo;
		return true;
	}
	
	/**
	 * Magics some money out of thin air
	 */
	function mint(string acctId, uint amount) ensureOwned {
		var acct = getAccount(acctId);
		acct.balance += amount;
		accounts[acctId] = acct;
	}
}
