---
sidebar_position: 3
---

# Generating the template

In VS Code, open a new terminal `Terminal > New Terminal`.

Enter the following command to generate a new project:

```bash
dotnet new aelf -n HelloWorld
```

# Verify that the template works

To verify that the template is working, try to build it:

```bash
cd src
dotnet build
```

A file at `src/bin/Debug/net6.0/HelloWorld.dll.patched` should be generated.
