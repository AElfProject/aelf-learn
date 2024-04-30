---
title: Portkey
description: First account abstraction (AA) wallet on aelf.
sidebar_position: 4
---

# Portkey Sign In

## 1. Introduction

[Portkey](https://portkey.finance/) is the first AA wallet from aelf's ecosystem, migrating users, developers and projects from Web2 to Web3 with DID solution.

The following example demonstrates how to integrate with Portkey wallet using `@portkey/detect-provider` npm package.

## 2. Create a sample project using react

```bash title="Terminal"
npm create vite@latest my-app -- --template react-swc-ts
```

Enter the project folder.

```bash title="Terminal"
cd my-app
```

## 3. Install SDK

```bash title="Terminal"
npm install @portkey/detect-provider
```

| Library                  | Description                                                                      |
| ------------------------ | -------------------------------------------------------------------------------- |
| @portkey/detect-provider | This library allows the developer to interact with the Portkey chrome extension. |

## 4. Integrate SignIn Component

### 4.1 Copy below sample code and replace the codes in src/App.tsx

```tsx title="src/App.tsx" showLineNumbers
import { useEffect, useState } from "react";
import { IPortkeyProvider, MethodsBase } from "@portkey/provider-types";
import "./App.css";
import detectProvider from "@portkey/detect-provider";

function App() {
  const [provider, setProvider] = useState<IPortkeyProvider | null>(null);

  // init function to initialise the provider
  const init = async () => {
    try {
      setProvider(await detectProvider());
    } catch (error) {
      console.log(error, "=====error");
    }
  };

  // if not already connected, will trigger the popup from the Chrome extension
  const connect = async () => {
    await provider?.request({
      method: MethodsBase.REQUEST_ACCOUNTS,
    });
  };

  // when provider has not been initialised, call the init function
  useEffect(() => {
    if (!provider) init();
  }, [provider]);

  if (!provider)
    return (
      <>
        Portkey extension not found. Please download{" "}
        <a
          href="https://chromewebstore.google.com/detail/portkey-wallet-crypto-gam/hpjiiechbbhefmpggegmahejiiphbmij?hl=en-GB"
          target="_blank"
          rel="noopener noreferrer"
        >
          here
        </a>
        .
      </>
    );

  return (
    <>
      <button onClick={connect}>Connect</button>
    </>
  );
}

export default App;
```

## 5. Start the development server

```bash title="Terminal"
npm run dev
```

## 6. Result

Click on the `connect` button.

If successful, the chrome extension should pop up requesting the user to connect to the application.

To find out more usage examples of Portkey, please click [here](https://doc.portkey.finance/).
