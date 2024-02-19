---
sidebar_position: 9
---

# Unit testing the smart contract

## Add a new test

Edit the file `test/HelloWorldTests.cs`:

```csharp
using System.Threading.Tasks;
using Google.Protobuf.WellKnownTypes;
using Shouldly;
using Xunit;

namespace AElf.Contracts.HelloWorld
{
    // This class is unit test class, and it inherit TestBase. Write your unit test code inside it
    public class HelloWorldTests : TestBase
    {
        // other tests...

        // highlight-start
        [Fact]
        public async Task Update_CountShouldBeAdded()
        {
            // Arrange
            var inputValue = "Hello, World!";
            var input = new StringValue { Value = inputValue };

            // Act
            await HelloWorldStub.Initialize.SendAsync(new Empty());
            await HelloWorldStub.Update.SendAsync(input);
            await HelloWorldStub.Read.CallAsync(new Empty());

            // Assert
            var count = await HelloWorldStub.GetCount.CallAsync(new Empty());
            count.Value.ShouldBe(1);
        }
        // highlight-end
    }

}
```

## Run the test

```bash
cd test
dotnet test
```

## Commit your changes

At this point, you may want to commit (save) your changes. To do so, click on the "Source Control" icon on the left, and enter a meaningful commit message, then click on `Commit` (hit Yes on the prompt if you wish to include all changes).
