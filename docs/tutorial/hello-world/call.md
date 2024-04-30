---
sidebar_position: 5
---

# Interact with the smart contract

Using `aelf-command` to call methods on your newly-deployed smart contract.

First of all, using `Update` method to set message. we run the following command,
and enter the message argument as `test`. Then `test` will be set into the message variable.

```bash title="Terminal"
aelf-command send $CONTRACT_ADDRESS -a $WALLET_ADDRESS -p $WALLET_PASSWORD -e $ENDPOINT Update
```

After that, using `Read` method to retrieve the value previously set for the message variable.
Then the value should be `test`.

```bash title="Terminal"
aelf-command call $CONTRACT_ADDRESS -a $WALLET_ADDRESS -p $WALLET_PASSWORD -e $ENDPOINT Read
```
