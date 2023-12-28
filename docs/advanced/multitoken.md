---
title: MultiToken contract
sidebar_position: 1
---
# MultiToken Contract Explanation

## Introduction

The AElf FT (Fungible Token) concept is implemented through the utilization of smart contracts on the AElf blockchain 
platform, and, in line with industry practices, employs a MultiToken contract. This contract facilitates core 
functionalities such as `creation`, `issuance`, `transfer`, `transferFrom`, `approval`, `burning`, and `locking` of 
tokens. In adherence to the definition of Fungible Tokens, each unit of AElf FT is interchangeable, possessing equal 
value and functionality.

Within the AElf ecosystem, FTs represent digital assets, benefiting from the versatility and programmability offered by 
smart contracts. The MultiToken contract enables developers to create fungible tokens tailored to specific business 
requirements. Users can seamlessly issue new FTs, conduct secure and trustworthy transfers between participants, provide 
additional approvals for more complex interactions, and engage in actions like burning or locking tokens when necessary. 
This modular design ensures that the AElf FT concept is adaptable to a variety of scenarios, catering to diverse user 
and enterprise needs.

## Functionalities of AElf MultiToken Contract

### 1. Create

The `Create` functionality in the AElf MultiToken contract is a pivotal feature that enables the introduction of new 
fungible tokens to the AElf blockchain. Through smart contracts, this functionality initiates the token creation process 
by generating a key-value pair in the state.TokenInfo hashmap, where the key represents the token symbol and the value 
contains essential information about the token. Symbol uniqueness is enforced, and developers benefit from a modular 
design, allowing customization based on specific business requirements. 

### 2. Issue

The `Issue` functionality in the AElf MultiToken contract is a core feature that facilitates the addition of a specified 
quantity of tokens to a designated user. This functionality is essential for the initial distribution and ongoing 
issuance of tokens within the AElf blockchain ecosystem. The user's token balance is then updated to reflect the issued 
amount, contributing to the total token supply. 

### 3. Transfer

The AElf MultiToken contract's `Transfer` function facilitates the transfer of a specified quantity of tokens from one 
user to another. The underlying implementation involves modifying the balances of both the sender and recipient 
addresses, ensuring the consistency and accuracy of token transfers. This function plays a fundamental role in enabling 
secure and efficient peer-to-peer transactions within the AElf blockchain ecosystem, enhancing the fungibility and 
usability of the tokens managed by the MultiToken contract.

```csharp
public override Empty Transfer(TransferInput input)
{
    AssertValidToken(input.Symbol, input.Amount);
    DoTransfer(Context.Sender, input.To, input.Symbol, input.Amount, input.Memo);
    DealWithExternalInfoDuringTransfer(new TransferFromInput
    {
        From = Context.Sender,
        To = input.To,
        Amount = input.Amount,
        Symbol = input.Symbol,
        Memo = input.Memo
    });
    return new Empty();
}
```

### 4. TransferFrom

The AElf MultiToken contract's TransferFrom function extends the token transfer capability by introducing the concept of 
an allowance, distinguishing it from the Transfer operation. For each user, spender, and token combination, the contract 
maintains an allowance in the state, represented as a Hashmap. This map specifies the maximum quantity of a particular 
token that the spender is authorized to transfer on behalf of the user. With each successful execution of TransferFrom, 
the contract deducts the transferred token amount from the corresponding allowance. This functionality is particularly 
useful in scenarios where users grant permission to a third party to manage their tokens. The TransferFrom operation 
validates the transaction parameters, including the spender, sender, recipient, and token amount. It ensures that the 
spender has the appropriate authorization to execute the transfer and updates the balances of the sender and recipient 
accordingly. This feature enhances the flexibility and utility of the AElf MultiToken contract in managing token 
transfers within the blockchain ecosystem.

```csharp
public override Empty TransferFrom(TransferFromInput input)
{
    AssertValidToken(input.Symbol, input.Amount);
    // First check allowance.
    var allowance = State.Allowances[input.From][Context.Sender][input.Symbol];
    if (allowance < input.Amount)
    {
        if (IsInWhiteList(new IsInWhiteListInput { Symbol = input.Symbol, Address = Context.Sender }).Value)
        {
            DoTransfer(input.From, input.To, input.Symbol, input.Amount, input.Memo);
            DealWithExternalInfoDuringTransfer(input);
            return new Empty();
        }

        Assert(false,
            $"[TransferFrom]Insufficient allowance. Token: {input.Symbol}; {allowance}/{input.Amount}.\n" +
            $"From:{input.From}\tSpender:{Context.Sender}\tTo:{input.To}");
    }

    DoTransfer(input.From, input.To, input.Symbol, input.Amount, input.Memo);
    DealWithExternalInfoDuringTransfer(input);
    State.Allowances[input.From][Context.Sender][input.Symbol] = allowance.Sub(input.Amount);
    return new Empty();
}
```

### 5. Approval

AElf MultiToken's `Approval` function is a critical feature that allows users to grant permission to a designated spender, 
specifying the maximum amount of tokens the spender is authorized to transfer on their behalf. This functionality is 
particularly useful in scenarios where users want to delegate token management to third parties, such as decentralized 
applications (DApps) or smart contracts. The Approval operation involves updating the allowance mapping in the 
contract's state, establishing a clear record of authorized spenders and their corresponding token limits. This 
capability enhances the flexibility and security of token management within the AElf blockchain ecosystem.

```csharp
public override Empty Approve(ApproveInput input)
{
    AssertValidToken(input.Symbol, input.Amount);
    State.Allowances[Context.Sender][input.Spender][input.Symbol] = input.Amount;
    Context.Fire(new Approved
    {
        Owner = Context.Sender,
        Spender = input.Spender,
        Symbol = input.Symbol,
        Amount = input.Amount
    });
    return new Empty();
}
```

### 6. Burning

The burning functionality in the AElf MultiToken contract allows users to permanently remove a specified quantity of 
tokens from circulation. The `Burn` function validates the parameters, ensuring the sender has a sufficient balance for 
the burn operation. Upon successful execution, the contract deducts the burned tokens from the sender's balance and 
updates the total token supply accordingly. Burning is a common feature used for various purposes, such as reducing 
token supply, adjusting economic parameters, or implementing deflationary mechanisms. This capability enhances the 
versatility and economic management aspects of the AElf MultiToken contract within the blockchain ecosystem.

```csharp
public override Empty Burn(BurnInput input)
{
    var tokenInfo = AssertValidToken(input.Symbol, input.Amount);
    Assert(tokenInfo.IsBurnable, "The token is not burnable.");
    ModifyBalance(Context.Sender, input.Symbol, -input.Amount);
    tokenInfo.Supply = tokenInfo.Supply.Sub(input.Amount);
    Context.Fire(new Burned
    {
        Burner = Context.Sender,
        Symbol = input.Symbol,
        Amount = input.Amount
    });
    return new Empty();
}
```

### 7. Locking

The locking functionality in AElf differs from time-based locks commonly seen in other systems. When the `Lock` function 
is called, the specified amount of tokens is transferred to a virtual address. There is no time duration set during the 
lock. The tokens remain at the virtual address until the `Unlock` function is called, at which point the locked tokens are 
transferred back to the user's address. This approach provides a unique mechanism where users have the ability to lock 
and unlock tokens without the constraint of a predefined time period, offering greater flexibility in managing token 
access within the AElf blockchain ecosystem.

```csharp
public override Empty Lock(LockInput input)
{
    AssertSystemContractOrLockWhiteListAddress(input.Symbol);
    Assert(Context.Origin == input.Address, "Lock behaviour should be initialed by origin address.");
    var allowance = State.Allowances[input.Address][Context.Sender][input.Symbol];
    if (allowance >= input.Amount)
        State.Allowances[input.Address][Context.Sender][input.Symbol] = allowance.Sub(input.Amount);
    AssertValidToken(input.Symbol, input.Amount);
    var fromVirtualAddress = HashHelper.ComputeFrom(Context.Sender.Value.Concat(input.Address.Value)
        .Concat(input.LockId.Value).ToArray());
    var virtualAddress = Context.ConvertVirtualAddressToContractAddress(fromVirtualAddress);
    // Transfer token to virtual address.
    DoTransfer(input.Address, virtualAddress, input.Symbol, input.Amount, input.Usage);
    DealWithExternalInfoDuringLocking(new TransferFromInput
    {
        From = input.Address,
        To = virtualAddress,
        Symbol = input.Symbol,
        Amount = input.Amount,
        Memo = input.Usage
    });
    return new Empty();
}
```

## AElf MultiToken Contract V.S. ETH ERC-20 Contract

1. **Divergent Locking Mechanism**: The locking functionality in the AElf MultiToken contract differs from traditional 
time-based locks in ERC-20 standards. In AElf, the Lock function transfers tokens to a virtual address without 
setting a time lock. These tokens stay in the virtual address until the Unlock function is called, transferring them 
back to the user's address. In ERC-20, time locks are typically implemented using smart contracts to restrict token 
transfers for a specified period.

2. **Advanced Allowance Management with TransferFrom**: AElf MultiToken introduces the Allowance concept and 
TransferFrom function for more flexible token transfers and permission management. This allows users to explicitly 
authorize specific spenders to execute transfers on their behalf. In ERC-20, authorization is typically achieved 
through the approval function, and the implementation of TransferFrom may vary between contracts.

3. **Modularity and Customization**: AElf MultiToken's modular design allows it to adapt flexibly to various scenarios, 
including user-defined features and business logic. In contrast, ERC-20 contracts have more standardized interfaces, 
constrained by the ERC-20 standard specification, which may limit flexibility compared to AElf contracts.

4. **Smart Contract Programming Language**: AElf smart contracts are written in C#, while ERC-20 contracts are usually 
coded in Solidity. 