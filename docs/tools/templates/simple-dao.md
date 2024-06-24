---
title: Simple DAO Smart Contract Template
sidebar_position: 2
---

# Simple DAO Smart Contract Template

## 1. Introduction

The SimpleDAO smart contract is designed to facilitate decentralized autonomous organization (DAO) operations on the AElf blockchain. It allows users to create proposals, vote on them, and withdraw tokens from voted ballots. The contract manages proposals and tracks voting status to ensure transparent and democratic decision-making within the DAO.

## 2. Setting up

**Prerequisite**:  
Install [aelf Contract Templates](index.md) to continue.

To spin up the SimpleDAO smart contract template project, use the following command:
```bash title="Terminal"
dotnet new aelf-simple-dao -n $DAO_NAME
```

## 3. Understanding Project Structure
```text title="SimpleDAO Project Structure"
src/
│
├── Protobuf/ # Protobuf definitions
│ ├── contract/
│ │ ├── simple_dao.proto # Protobuf file for SimpleDAO contract
│ ├── message/
│ │ ├── authority_info.proto # Protobuf file for authority information messages
│ ├── reference/
│ │ ├── acs12.proto # Protobuf file for ACS12 reference
│ │ ├── token_contract.proto # Protobuf file for token contract reference
│
├── ContractReference.cs # State referencing contracts
├── SimpleDAO.cs # Main C# file for SimpleDAO smart contract implementation
├── SimpleDAO_Helper.cs # Helper functions for SimpleDAO
├── SimpleDAOState.cs # State management for SimpleDAO, all States goes here
├── SimpleDAO.csproj # csproj

test/ # Test project for SimpleDAO
│
├── Protobuf/ # Protobuf definitions for tests
│ ├── message/
│ │ ├── authority_info.proto # Protobuf file for authority information messages (for testing)
│ ├── reference/
│ │ ├── acs12.proto # Protobuf file for ACS12 reference (for testing)
│ ├── stub/
│ │ ├── simple_dao.proto # Protobuf file for SimpleDAO contract (stub for testing)
│ │ ├── token_contract.proto # Protobuf file for token contract reference (stub for testing)
│
├── _Setup.cs # Setup script for tests
├── SimpleDAOTests.cs # Main unit test file for SimpleDAO
├── SimpleDAO.Tests.csproj # csproj
```

## 4. Understanding Interfaces

### Initialize
Initializes the DAO and sets the token symbol for the DAO members.
```csharp
public override Empty Initialize(InitializeInput input)
```
- **Parameters:**
  - `InitializeInput input`: Contains the token symbol to be used by the DAO.
- **Returns:** `Empty`
- **Assertions:**
  - The contract should not be already initialized.
  - The token contract address must be retrievable.
  - The token symbol provided should exist.

### CreateProposal
Creates a new proposal in the DAO.
```csharp
public override Empty CreateProposal(CreateProposalInput input)
```
- **Parameters:**
  - `CreateProposalInput input`: Contains details of the proposal such as title, description, start time, and end time.
- **Returns:** `Empty`
- **Assertions:**
  - Title and description should not be empty.
  - Start time should be greater than or equal to the current block time.
  - End time should be greater than the current block time.

### Vote
Allows members to vote on a proposal.
```csharp
public override Empty Vote(VoteInput input)
```
- **Parameters:**
  - `VoteInput input`: Contains proposal ID and vote details.
- **Returns:** `Empty`
- **Assertions:**
  - Proposal must exist.
  - Voting should be within the proposal's timeframe.
  - Voter should not have already voted on the proposal.

### Withdraw
Allows members to withdraw their vote from a proposal after it has ended.
```csharp
public override Empty Withdraw(WithdrawInput input)
```
- **Parameters:**
  - `WithdrawInput input`: Contains proposal ID.
- **Returns:** `Empty`
- **Assertions:**
  - Proposal must exist.
  - Proposal should have ended.

### GetAllProposals
Returns a list of all proposals in the DAO.
```csharp
public override ProposalList GetAllProposals(Empty input)
```
- **Parameters:**
  - `Empty input`
- **Returns:** `ProposalList`

### GetProposal
Returns details of a specific proposal.
```csharp
public override Proposal GetProposal(StringValue input)
```
- **Parameters:**
  - `StringValue input`: Contains the proposal ID.
- **Returns:** `Proposal`
- **Assertions:**
  - Proposal must exist.

### HasVoted
Checks if a specific address has voted on a proposal.
```csharp
public override BoolValue HasVoted(HasVotedInput input)
```
- **Parameters:**
  - `HasVotedInput input`: Contains proposal ID and address.
- **Returns:** `BoolValue`

### GetTokenSymbol
Returns the token symbol used by the DAO.
```csharp
public override StringValue GetTokenSymbol(Empty input)
```
- **Parameters:**
  - `Empty input`
- **Returns:** `StringValue`

## 5. Preparing for deployment

### 5.1 Creating A Wallet

import CreateWallet from '@site/docs/\_create-wallet.md';

<CreateWallet/>

### 5.2 Acquiring Testnet Tokens for Development

import GetTestnetToken from '@site/docs/\_get-testnet-token.md';

<GetTestnetToken/>

### 5.3 Building your Smart Contract

Build the code with the following commands:

```bash title="Terminal"
cd src
dotnet build
```

## 6. Deploying Your Smart Contract

import DeploySmartContract from '@site/docs/\_deploy-smart-contract.md';

<DeploySmartContract/>