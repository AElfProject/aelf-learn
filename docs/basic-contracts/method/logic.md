---
title: Logic
sidebar_position: 2
---

- Access the context (block time, block height)
- How do you operate on the state
- How do you fire events
- How do you call another contract - different from EVM
  - EVM: depth first - wait for response from other contract
  - aelf: breadth first - execute current contract first, then execute inline transaction recursively
