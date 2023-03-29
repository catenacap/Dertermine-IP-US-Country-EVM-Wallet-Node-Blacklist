pragma solidity ^0.8.0;

contract USRestriction { mapping (address => string) private _walletCountry; mapping (address => string) private _nodeCountry; mapping (address => bool) private _blacklistedWallets;

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
