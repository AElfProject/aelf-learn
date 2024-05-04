---
title: Hello World
sidebar_position: 1
---

# Hello World

## 1. Introduction

This guide teaches you how to create aelf smart contracts, using the example of the HelloWorldContract. By following the instructions here, you'll learn to make your own basic contracts and interact with it on-chain.

## 2. Setting Up Your Development Environment

import Codespace from '@site/docs/\_prep-codespace.md';

<Codespace/>

## 3. Starting Your Smart Contract Project

Open your `Terminal`.

Enter the following command to generate a new project:

```bash title="Terminal"
dotnet new aelf -n HelloWorld
```

## 4. Adding Your Smart Contract Code

Now that we have a template hello world project, we can customize the template to incorporate our own contract logic.
Lets start by implementing methods to provide basic functionality for updating and reading a message stored persistently in the contract state.

```csharp title="src/HelloWorldState.cs"
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

```csharp title="src/HelloWorld.cs"
// contract implementation starts here
namespace AElf.Contracts.HelloWorld
{
    public class HelloWorld : HelloWorldContainer.HelloWorldBase
    {
        // A method that updates the contract state, Message with a user input
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

        // A method that reads the contract state, Message
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

Build the new code with the following commands:

```bash title="Terminal"
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

Lets try to call methods on your newly-deployed smart contract using `aelf-command`.

Firstly, we will set a message using the `Update` method. Run the following command,
and enter the message argument as `test`. This will set `test` into the Message contract state.

```bash title="Terminal"
aelf-command send $CONTRACT_ADDRESS -a $WALLET_ADDRESS -p $WALLET_PASSWORD -e https://tdvw-test-node.aelf.io Update
```

After that, we can use `Read` method to retrieve the value previously set for the Message contract state.
Running the following command should yield `test`.

```bash title="Terminal"
aelf-command call $CONTRACT_ADDRESS -a $WALLET_ADDRESS -p $WALLET_PASSWORD -e https://tdvw-test-node.aelf.io Read
```
