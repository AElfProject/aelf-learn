---
title: Nft Sale Smart Contract Template
sidebar_position: 2
---

# Nft Sale Smart Contract Template

## 1. Introduction

The NftSale smart contract is designed to facilitate on the aelf blockchain, empowering users to trade and explore digital collectables.

## 2. Setting up

**Prerequisite**:  
Install [aelf Contract Templates](index.md) to continue.

To spin up the NftSale smart contract template project, use the following command:
```bash title="Terminal"
dotnet new aelf-nft-sale -n $NFT_SALE_NAME
```

## 3. Understanding Project Structure
```text title="NftSale Project Structure"
src/
│
├── Protobuf/ # Protobuf definitions
│ ├── contract/
│ │ ├── nft_sale_contract.proto # Protobuf file for NftSale contract
│ ├── message/
│ │ ├── authority_info.proto # Protobuf file for authority information messages
│ ├── reference/
│ │ ├── acs12.proto # Protobuf file for ACS12 reference
│ │ ├── token_contract.proto # Protobuf file for token contract reference
│
├── ContractReference.cs # State referencing contracts
├── NftSale.cs # Main C# file for NftSale smart contract implementation
├── NftSaleState.cs # State management for NftSale, all States goes here
├── NftSale.csproj # csproj

test/ # Test project for NftSale
│
├── Protobuf/ # Protobuf definitions for tests
│ ├── message/
│ │ ├── authority_info.proto # Protobuf file for authority information messages (for testing)
│ ├── reference/
│ │ ├── acs12.proto # Protobuf file for ACS12 reference (for testing)
│ ├── stub/
│ │ ├── nft_sale_contract.proto # Protobuf file for NftSale contract (stub for testing)
│ │ ├── token_contract.proto # Protobuf file for token contract reference (stub for testing)
│
├── _Setup.cs # Setup script for tests
├── NftSaleTests.cs # Main unit test file for NftSale
├── NftSale.Tests.csproj # csproj
```

## 4. Understanding Interfaces

### Initialize
Initializes the Contract.
```csharp
public override Empty Initialize(InitializeInput input)
```
- **Parameters:**
    - `InitializeInput input`: `Empty`.
- **Returns:** `Empty`
- **Assertions:**
    - The contract should not be already initialized.
    - The token contract address must be retrievable.
    - The token symbol provided should exist.

### SaleNft
Users sell their nft by special token.
```csharp
public override Empty Purchase(PurchaseInput input)
```
- **Parameters:**
    - `WithdrawInput input`: Contains symbol amount and price.
- **Returns:** `Empty`
- **Assertions:**
Balance is must sufficient.

### SetPrice
Set symbol price.
```csharp
public override Empty SetPrice(NftPrice input)
```
- **Parameters:**
  - `NftPrice input`: Contains symbol amount and price.
- **Returns:** `Empty`
- **Assertions:**
  - set success.


### GetPrice
Set symbol price.
```csharp
public override Price GetPrice(GetSymbolPriceInput input)
```
- **Parameters:**
  - `GetSymbolPriceInput input`: Contains symbol.
- **Returns:** `symbol price`
- **Assertions:**
  - set success.

### Withdraw
Allow users to cancel orders.
```csharp
public override Empty Withdraw(WithdrawInput input)
```
- **Parameters:**
  - `WithdrawInput input`: Contains proposal ID.
- **Returns:** `Empty`
- **Assertions:**
  - Proposal must exist.
  - Proposal should have ended.

## 6. Deploying Your Smart Contract

import DeploySmartContract from '@site/docs/\_deploy-smart-contract.md';

<DeploySmartContract/>
