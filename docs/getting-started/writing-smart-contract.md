---
sidebar_position: 8
---

# Writing the smart contract

Now that we understand how a smart contract for aelf is written, suppose we want to modify the default example to implement our own contract logic.

## Modify the example

Suppose we want to capture the number of calls to the `Update` method.

### State changes

Edit the file `src/HelloWorldState.cs`:

```csharp
using AElf.Sdk.CSharp.State;

namespace AElf.Contracts.HelloWorld
{
    // The state class is access the blockchain state
    public class HelloWorldState : ContractState
    {
        // A state that holds string value
        public StringState Message { get; set; }
        // highlight-next-line
        public Int64State Count { get; set; }
    }
}
```

Edit the file `src/Protobuf/contract/hello_world_contract.proto`:

```protobuf
// other code...

service HelloWorld {
  // other code...

  // highlight-start
  rpc GetCount (google.protobuf.Empty) returns (google.protobuf.Int64Value) {
    option (aelf.is_view) = true;
  }
  // highlight-end

  // other code...
}

// other code...
```

Edit the file `src/HelloWorld.cs` to add the method implementation:

```csharp
// other code...
namespace AElf.Contracts.HelloWorld
{
    public class HelloWorld : HelloWorldContainer.HelloWorldBase
    {
        // other methods...

        public override Empty Update(StringValue input)
        {
            // Set the message value in the contract state
            State.Message.Value = input.Value;
            // highlight-next-line
            State.Count.Value += 1;
            // Emit an event to notify listeners about something happened during the execution of this method
            Context.Fire(new UpdatedMessage
            {
                Value = input.Value
            });
            return new Empty();
        }

        // highlight-start
        public override Int64Value GetCount(Empty input)
        {
            return new Int64Value
            {
                Value = State.Count.Value
            };
        }
        // highlight-end
    }
}
```

### Build the new contract

Try to build the new code:

```bash
cd src
dotnet build
```
