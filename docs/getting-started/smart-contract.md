---
sidebar_position: 7
---

# Introduction to smart contract on the aelf blockchain

A smart contract is a self-executing digital contract written in code and deployed on a blockchain. It automates the execution of contractual terms and conditions when predefined criteria are met, reducing the need for intermediaries and enhancing transparency and security. Operating on decentralized blockchain networks, smart contracts are immutable, meaning their code cannot be altered once deployed. This ensures the integrity of the contract and promotes trust among parties involved. Smart contracts find applications across various industries, offering automation, cost-efficiency, and trust in sectors such as finance, supply chain management, and real estate. Platforms like Ethereum, Binance Smart Chain, and Cardano support the development and execution of smart contracts, revolutionizing traditional contract processes.

In the context of aelf, a blockchain platform designed for creating decentralized applications (DApps) and enterprise-grade solutions, smart contracts play a crucial role in automating and securing various processes. aelf incorporates a unique approach to smart contracts by implementing a multi-chain architecture, where each DApp operates on a separate sidechain, fostering scalability and performance.

aelf's smart contracts are deployed on specific sidechains, ensuring isolation and preventing congestion on the main chain. This design enhances the efficiency and scalability of the network. The aelf smart contract is written in C#, providing flexibility and accessibility for developers.

## View Methods

By default, States defined in the contract cannot be accessed through external sources unless the contract developer implements a view method specifically designed to expose the value of a State.

To define a **view** method in the proto file of the contract, you need to add `option (aelf.is_view) = true;` to the rpc method.

```protobuf
rpc Read (google.protobuf.Empty) returns (google.protobuf.StringValue) {
  option (aelf.is_view) = true;
}
```

## `Read` method

The Read method aims to expose the value of `State.Message.Value` is actually very straightforward to implement.

```csharp
// A method that read the contract state
public override StringValue Read(Empty input)
{
    // Retrieve the value from the state
    var value = State.Message.Value;
    // Wrap the value in the return type
    return new StringValue
    {
        Value = value
    };
}
```

## `ReadMessage` method

You can define another method to expose the value of the mapped state `State.Messages`.

```protobuf
rpc ReadMessage (google.protobuf.Int32Value) returns (google.protobuf.StringValue) {
  option (aelf.is_view) = true;
}
```

And the implementation can be:

```csharp
public override StringValue ReadMessage(Int32Value input)
{
    return new StringValue
    {
        Value = State.Messages[input.Value]
    };
}
```

:::tip

It is worth noting that when you call any View method, its return value will not be null. If the state does not exist and the return value is of type StringValue, the return value will be a:

```csharp
new StringValue()
{
    Value = ""
};
```

:::

## Inline Contract Call

When you need to call methods from other contracts during the implementation of your own contract methods, there are two types:

1. Call view methods without expecting to modify any states of other contracts.
2. Call action methods and hope that the states of other contracts will be modified because of this calling.

For the first type, you can use `Context.Call` method to complete the call to the view methods and immediately obtain the return value, which can be applied in the context of the contract implementation.

For the second type, during the implementation of the AELF contract, all you can do is prepare a transaction without a signature (we call it an **inline transaction**) and **add it to a list**. Transactions on this list will be executed one by one recursively, following the completion of the code for the method you have implemented, based on the time it was added.

Therefore, it should be noted that on aelf, when you try to modify the states of other contracts, the modification does not occur immediately. It can only be gradually modified through **inline transactions** after the current contract method has been fully executed. This is different from EVM.

You can use the `Context.SendInline` method to add an inline transaction to the current executing context.

```csharp
// A method that modifies the contract state
public override Empty Update(StringValue input)
{
    var tokenContractAddress = Context.GetContractAddressByName(SmartContractConstants.TokenContractSystemName);
    // Do not forget to reference token_contract.proto to generate the TransferInput type.
    Context.SendInline(tokenContractAddress, "Transfer", new TransferInput
    {
        To = receiverAddress,
        Symbol = "ELF",
        Amount = 100
    });
    // Set the message value in the contract state
    State.Message.Value = input.Value;
    // Emit an event to notify listeners about something happened during the execution of this method
    Context.Fire(new UpdatedMessage
    {
        Value = input.Value
    });
    return new Empty();
}
```

In the above example, an inline transaction for transfer was added in the beginning of Update method, which attempts to call the **Transfer** method of the **MultiToken Contract** (one of the System Contracts) and will only be executed after the Update method is completed.

Of course, cross contract calls can also be completed through **ContractReferenceState**. ContractReferenceState is only meant to facilitate developers to call methods in other contracts, essentially the `Context.Call` and `Context.SendInline` are used to complete such tasks.

## Events

Contracts can emit events that signal that changes have occurred. Unlink building view methods and waiting for external calls to expose states, events are stored in the blockchain transaction log, so they become part of the permanent record.

Once those events are added to the chain, an off-chain application can listen to events.

For example, in the implementation of the Update method in the **HelloWorld** contract, you can emit (fire) an event to notify the outside world that the status of the Message has changed.

```csharp
// A method that modifies the contract state
public override Empty Update(StringValue input)
{
    // Set the message value in the contract state
    State.Message.Value = input.Value;
    // Emit an event to notify listeners about something happened during the execution of this method
    Context.Fire(new UpdatedMessage
    {
        Value = input.Value
    });
    return new Empty();
}
```

The definition of UpdatedMessage is:

```protobuf
// An event that will be emitted from contract method call
message UpdatedMessage {
  option (aelf.is_event) = true;
  string value = 1;
}
```

:::tip

Remember to add option `option (aelf.is_event) = true;` to ensure that this message will be emitted as an event.

:::

We have designed the `aelf.is_indexed` option for the fields of event message, but in reality, it has no effect.

```protobuf
// An event that will be emitted from contract method call
message UpdatedMessage {
  option (aelf.is_event) = true;
  string value = 1 [(aelf.is_indexed) = true];
}
```

It's just that when reading events, their information is included in two properties: **Indexed** and **NonIndexed**. Like in the above definition, after adding `[(aelf.is_indexed) = true]`, the value field will go from **NonIndexed** to **Indexed**.

### Definition of event

The following is the definition of event on aelf.

```protobuf
message LogEvent {
    // The contract address.
    Address address = 1;
    // The name of the log event.
    string name = 2;
    // The indexed data, used to calculate bloom.
    repeated bytes indexed = 3;
    // The non indexed data.
    bytes non_indexed = 4;
}
```

**Indexed** is a list, **NonIndexed** is a single object.

And to encode an event, the proto file that defines this event must be known.
