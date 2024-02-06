---
sidebar_position: 4
---

# Template structure

After generating the template, there will be two folders created, `src` and `test`.

# `src` folder

```bash
src
├── HelloWorld.cs
├── HelloWorld.csproj
├── HelloWorldState.cs
└── Protobuf
    ├── contract
    │   └── hello_world_contract.proto
    └── message
        └── authority_info.proto
```

The `src` folder contains the smart contract code.

# `test` folder

```bash
test
├── HelloWorldTests.cs
├── HelloWorld.Tests.csproj
├── Protobuf
│   ├── message
│   │   └── authority_info.proto
│   └── stub
│       └── hello_world_contract.proto
└── _Setup.cs
```

The `test` folder contains the test code used to test the smart contract implementation in the `src` folder.
