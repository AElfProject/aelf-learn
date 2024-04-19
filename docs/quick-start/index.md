---
title: Quick Start
sidebar_position: 1
---
# Quick Start

## Introduction

This documentation will guide you on how to develop the aelf smart contract, and it uses the HelloWorldContract as an example.
With the concepts presented in this article, you will be able to create your own basic contract.

## Setting Up Your Development Environment

The easiest way to get started is to use this repository template: https://github.com/yongenaelf/aelf-devcontainer-template.

Click on the `Use this template` button and choose `Create a new repository`.

Type a suitable repository name and click `Create repository`.

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

<Tabs>
  <TabItem value="codespaces" label="GitHub Codespaces" default>

Within the GitHub interface, click on `Code`, then choose `Codespaces`.

Click on the plus "+" sign to create a new Codespace.

After a moment, your workspace will load with the contents of the repository, and you will be able to continue your development using GitHub Codespaces.

![codespaces](/img/codespaces.png)

</TabItem>
  <TabItem value="local" label="Local Development">

Clone your repository to your local working directory.

### Install Required Software

To use the template locally, install the following:

- [Docker](https://www.docker.com/get-started/)
- [VS Code](https://code.visualstudio.com/)

### Start Docker

Ensure that Docker is running (if not, start Docker).

### Open Project Folder in VS Code

Open the project folder in VS Code.

Next, press `F1` and enter `reopen`, then choose `Dev Containers: Reopen in Container`.

Wait while the environment loads.
</TabItem>
</Tabs>

## Configuring Your Smart Contract Project

In VS Code, open a new terminal `Terminal > New Terminal`.

Enter the following command to generate a new project:

```bash
dotnet new aelf -n HelloWorld
```

## Creating Your Smart Contract Code

Now that we understand how a smart contract for aelf is written, suppose we want to modify the default example to implement our own contract logic.

### Modify the Example

Suppose we want to capture the number of calls to the `Update` method.

#### State Changes

Edit the file `src/HelloWorldState.cs`:

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

Edit the file `src/Protobuf/contract/hello_world_contract.proto`:

```protobuf
// other code...

service HelloWorld {
  // other code...

  // highlight-start
  rpc Update (google.protobuf.StringValue) returns (google.protobuf.Empty) {
  }
  rpc Read (google.protobuf.Empty) returns (google.protobuf.StringValue) {
    option (aelf.is_view) = true;
  }
  // highlight-end

  // other code...
}

// other code...
```

Edit the file `src/HelloWorld.cs` to add the method implementation:

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

#### Build the New Contract

Try to build the new code:

```bash
cd src
dotnet build
```

[//]: # (![commit]&#40;/img/repository-commit.png&#41;)

## Deploying Your Smart Contract

The smart contract needs to be deployed on the chain before users can use it.

### Deployment

Run this command to deploy a contract.

```
aelf-local -a <Wallet_Address> -p <Wallet_Password> -c <Contract_Path>/<Contract_File>.dll.patched
```

Wait about 1-2 minutes. If deployment is successful, it will return the contract address.

![result](/img/deploy-result.png)

## Interacting with Your Deployed Smart Contract

To call methods on your newly-deployed smart contract, use `aelf-command`:

Using `Update` method to set message.

```bash
aelf-command send $CONTRACT_ADDRESS -a $WALLET_ADDRESS -p $WALLET_PASSWORD -e $ENDPOINT Update 
```

Using `Read` method to get message.

```bash
aelf-command call $CONTRACT_ADDRESS -a $WALLET_ADDRESS -p $WALLET_PASSWORD -e $ENDPOINT Read 
```

## Acquiring Testnet Tokens for Development

Developers can leverage the aelf testnet network available at https://aelf-test-node.aelf.io/ for thorough testing of their smart contracts during the development phase.
To acquire testnet tokens for covering transaction fees essential for contract deployment.

Run this command to get token from faucet.

```
curl --location 'https://faucet.aelf.dev/api/app/send-token-info' \
--header 'Content-Type: application/json' \
--data '{"walletAddress": "aaa"}'
```