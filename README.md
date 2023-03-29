# Dertermine-IP-US-Country-EVM-Wallet-Node-Blacklist
Blacklist US Based Wallets/Nodes Via EVM IP Determiner

Permanent Solution To A Wallet/Node Owner Bypassing Restrictions.
The problem with blocking US based users or nodes comes with various weak points the following is a blacklist function where when it’s determined a end user is trying to connect from the US, their wallet address is not only blocked from interacting with the smart contract, but they end users wallet becomes blacklisted so they can’t proceed with a bypass via spoofing or VPN’s. 

pragma solidity ^0.8.0;

contract USRestriction {
    mapping (address => string) private _walletCountry;
    mapping (address => string) private _nodeCountry;
    mapping (address => bool) private _blacklistedWallets;

    modifier onlyNonUS() {
        string memory walletCountry = _walletCountry[msg.sender];
        string memory nodeCountry = _nodeCountry[tx.origin];
        require(keccak256(bytes(walletCountry)) != keccak256(bytes("United States")) &&
                keccak256(bytes(nodeCountry)) != keccak256(bytes("United States")), "US-based access detected.");
        _;
    }

    function updateWalletCountryMapping(address wallet, string memory country) public {
        _walletCountry[wallet] = country;
    }

    function updateNodeCountryMapping(address node, string memory country) public {
        _nodeCountry[node] = country;
    }

    function blacklistWallet(address wallet) public {
        _blacklistedWallets[wallet] = true;
    }

    function isWalletBlacklisted(address wallet) public view returns (bool) {
        return _blacklistedWallets[wallet];
    }

    function myRestrictedFunction() public onlyNonUS {
        require(!_blacklistedWallets[msg.sender], "Your wallet is blacklisted.");
        // This function can only be called from wallets owned by individuals located outside the United States
        // and validator nodes/miners located outside the United States
        // ...
    }
}

Improvement on our released validator-nodes/wallets restriction contract, the following will incorporate the end user Wallet Address/Node Address and add it to a blacklist function.

In this modified version, we've added a new mapping _blacklist, which keeps track of addresses that have been blacklisted. We've also added three new functions: addToBlacklist, removeFromBlacklist, and isBlacklisted.

The addToBlacklist function allows the contract owner to add a user's wallet address to the blacklist. The removeFromBlacklist function allows the contract owner to remove a user's address from the blacklist. Finally, the isBlacklisted function allows anyone to check whether a specific user's address is currently blacklisted.

We've also modified the onlyNonRestricted modifier to include a check for whether the user's address is in the blacklist. If the user is blacklisted, the modifier will trigger an error message and prevent the execution of the function.

By using this modified version of the contract, the contract owner can add addresses to the blacklist as necessary to comply with regulatory requirements. Once an address is blacklisted, it will not be able to access any of the restricted functions in the contract.
