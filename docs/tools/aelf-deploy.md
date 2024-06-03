---
title: Protobuf Extension
sidebar_position: 3
---

# aelf Deploy Tool

## 1. Introduction

aelf-deploy is a tool for deploying & updating aelf contracts easily using your command prompt.

## 2. Setting up

```bash title="Terminal"
dotnet tool install --global aelf.deploy
```

## 3. Using aelf-deploy

**Example**:
```bash title="Terminal"
aelf-deploy -a $WALLET_ADDRESS -p $WALLET_PASSWORD -c $CONTRACT_PATH/$CONTRACT_FILE.dll.patched -e https://tdvw-test-node.aelf.io/
```

**Options**

-a: Address.  
-p: Password of keystore file.  
-c: contract dll location.  
-u: true meant to update contract. Default is false.  
-e: Endpoint. By default: 127.0.0.1:8000.  
-i: With or without audit. By default, it's false, which means deploy without audit.  
-s: Salt, used to calculate contract addresses. If not provided, it's the hash of the contract code.  
-o: Should be false if the deployer is an EOA address. It's false by default.  
-t: Specify the contract address you want to update.  
-k: Private Key.