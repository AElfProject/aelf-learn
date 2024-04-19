---
title: Faucet
sidebar_position: 4
---

# Faucet

## Introduction

Developers can leverage the aelf testnet network available at https://aelf-test-node.aelf.io/ for thorough testing of their smart contracts during the development phase.
To acquire testnet tokens for covering transaction fees essential for contract deployment.

## Getting testnet tokens

Run this command to get token from faucet.

```
curl --location 'https://faucet.aelf.dev/api/app/send-token-info' \
--header 'Content-Type: application/json' \
--data '{"walletAddress": "aaa"}'
```