---
title: Quick Start
sidebar_position: 1
---

# Quick Start

## 1. Introduction

This guide teaches you how to create aelf smart contracts, using the example of the HelloWorldContract. By following the instructions here, you'll learn to make your own basic contracts and interact with it on-chain.

## 2. Setting Up Your Development Environment

import Codespace from '@site/docs/\_prep-codespace.md';

<Codespace/>

## 3. Starting Your Smart Contract Project

Open your `Terminal`.

Enter the following command to generate a new project:

```bash
dotnet new aelf -n HelloWorld
```

## 4. Adding Your Smart Contract Code

Now that we understand how a smart contract for aelf is written, suppose we want to modify the default example to implement our own contract logic.

```csharp
using AElf.Sdk.CSharp.State;

namespace AElf.Contracts.HelloWorld
{
    // The state class is access the blockchain state
    public class HelloWorldState : ContractState
    {
        // A state that holds string value
        // highlight-next-line
        public StringState Message { get; set; }
    }
}
```

The implementation of file `src/HelloWorld.cs` is as follows:

```csharp
// other code...
namespace AElf.Contracts.HelloWorld
{
    public class HelloWorld : HelloWorldContainer.HelloWorldBase
    {
        // other methods...
        // highlight-start
        public override Empty Update(StringValue input)
        {
            State.Message.Value = input.Value;
            Context.Fire(new UpdatedMessage
            {
                Value = input.Value
            });
            return new Empty();
        }

        // A method that read the contract state
        public override StringValue Read(Empty input)
        {
            var value = State.Message.Value;
            return new StringValue
            {
                Value = value
            };
        }
        // highlight-end
    }
}
```

Try to build the new code:

```bash
cd src
dotnet build
```

## 5. Preparing for deployment

### Creating A Wallet

import CreateWallet from '@site/docs/\_create-wallet.md';

<CreateWallet/>

### Acquiring Testnet Tokens for Development

import GetTestnetToken from '@site/docs/\_get-testnet-token.md';

<GetTestnetToken/>

## 6. Deploying Your Smart Contract

import DeploySmartContract from '@site/docs/\_deploy-smart-contract.md';

<DeploySmartContract/>

## 7. Interacting with Your Deployed Smart Contract

Using `aelf-command` to call methods on your newly-deployed smart contract.

First of all, using `Update` method to set message. we run the following command,
and enter the message argument as `test`. Then `test` will be set into the message variable.

```bash
aelf-command send $CONTRACT_ADDRESS -a $WALLET_ADDRESS -p $WALLET_PASSWORD -e $ENDPOINT Update
```

After that, using `Read` method to retrieve the value previously set for the message variable.
Then the value should be `test`.

```bash
aelf-command call $CONTRACT_ADDRESS -a $WALLET_ADDRESS -p $WALLET_PASSWORD -e $ENDPOINT Read
```
