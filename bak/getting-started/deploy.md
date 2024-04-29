---
sidebar_position: 5
---

# Smart Contract Deployment

The smart contract needs to be deployed on the chain before users can use it.

## Get token from faucet

Reference [documentation](/faucet) to get token from faucet.

## Deployment

Run this command to deploy a contract.

```
aelf-local -a <Wallet_Address> -p <Wallet_Password> -c <Contract_Path>/<Contract_File>.dll.patched
```

Wait about 1-2 minutes. If deployment is successful, it will return the contract address.

![result](/img/deploy-result.png)