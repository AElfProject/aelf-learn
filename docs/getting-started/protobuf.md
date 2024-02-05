---
sidebar_position: 5
---

# Introduction to protobuf

Observe that there is a `Protobuf` folder in the `src` folder.

Inside this folder, there is a file at `src/Protobuf/contract/hello_world_contract.proto`:

```protobuf
syntax = "proto3";

import "aelf/options.proto";
import "google/protobuf/empty.proto";
import "google/protobuf/wrappers.proto";
// The namespace of this class
option csharp_namespace = "AElf.Contracts.HelloWorld";

service HelloWorld {
  // The name of the state class the smart contract is going to use to access blockchain state
  option (aelf.csharp_state) = "AElf.Contracts.HelloWorld.HelloWorldState";

  // Actions (methods that modify contract state)
  // Stores the value in contract state
  rpc Update (google.protobuf.StringValue) returns (google.protobuf.Empty) {
  }

  // Views (methods that don't modify contract state)
  // Get the value stored from contract state
  rpc Read (google.protobuf.Empty) returns (google.protobuf.StringValue) {
    option (aelf.is_view) = true;
  }
}

// An event that will be emitted from contract method call
message UpdatedMessage {
  option (aelf.is_event) = true;
  string value = 1;
}
```

This file will be the main protobuf file you will work with when you are creating your smart contract.

# A quick explanation

## Service interface

```protobuf
service HelloWorld {
  // ...
}
```

Your contract methods should be declared inside this service.

## Contract methods

### Read-only methods

```protobuf
service HelloWorld {
  // ...
  rpc Read (google.protobuf.Empty) returns (google.protobuf.StringValue) {
    option (aelf.is_view) = true;
  }
  // ...
}
```

Read-only methods (Views) are declared in this way, with the line `option (aelf.is_view) = true;`.

### Write methods

```protobuf
service HelloWorld {
  // ...
  rpc Update (google.protobuf.StringValue) returns (google.protobuf.Empty) {
  }
  // ...
}
```

Methods that modify contract state (Actions) are declared in this way, without the `option ...`.

### Events

```protobuf
message UpdatedMessage {
  option (aelf.is_event) = true;
  string value = 1;
}
```

Events that are emitted from method calls are declared in this way.
