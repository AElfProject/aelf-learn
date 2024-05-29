---
title: Lottery Game Contract
sidebar_position: 3
---
# Lottery Game Contract

## Introduction
In this tutorial, you'll delve into creating a simple lottery game powered by the LotteryGame smart contract, a decentralized application on the aelf blockchain platform. This contract facilitates various game functionalities, such as initialization, gameplay mechanics, token deposits and withdrawals, and the seamless transfer of contract ownership. Participants will engage using ELF tokens, utilizing them to enter draws, with winnings distributed from a designated token pool based on chance.

## Prerequisites

- [Vote Contract](../stackup/index.md)

## Topics Covered

 1. Develop and deploy a smart contract that utilises the Multitoken System Contract.

 2. Reference other deployed contracts in your smart contract.

## Key Features
- Initialization:
> The Initialize method sets up the contract by defining the owner and referencing the MultiToken contract. This step ensures that the contract is ready to interact with the token contract on the aelf blockchain.

- Playing the Game:
> The Play method allows users to participate in the lottery by specifying an amount of ELF tokens. The method checks if the amount is within predefined limits and if the player has sufficient balance. The game outcome is determined by a simple random mechanism, and tokens are transferred accordingly. Winning or losing outcomes are recorded through events.

- Depositing Tokens:
> The Deposit method enables the contract owner to deposit ELF tokens into the contract. This increases the token pool available for the lottery payouts. The method also emits an event to record the deposit.

- Withdrawing Tokens:
> The Withdraw method allows the contract owner to withdraw a specified amount of tokens from the contract. This is crucial for managing the contract's token pool and ensuring that funds are available when needed. Withdrawal actions are also recorded through events.

- Ownership Management:
> The TransferOwnership method provides a way to transfer the ownership of the contract to another address. This ensures that the contract can be managed by a new owner if necessary.

- Query Functions:
> Several view methods such as GetPlayAmountLimit, GetContractBalance, and GetOwner provide insights into the contract’s current state, including the play amount limits, the contract's balance, and the owner's address.
Detailed Functionality