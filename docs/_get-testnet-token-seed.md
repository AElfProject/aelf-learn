Acquire testnet SEED for creating fungible or non-fungible tokens on aelf testnet.

**Get ELF Seed**

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

<Tabs>
  <TabItem value="cli" label="CLI" default>

Run this command to get seed from faucet.

```
curl --location 'https://faucet.aelf.dev/api/claim-seed' \
--header 'Content-Type: application/json' \
--data '{"walletAddress": "Your wallet address"}'
```

  </TabItem>
  <TabItem value="web" label="Web" default>

Go to this url [https://faucet-ui-preview.vercel.app](https://faucet-ui-preview.vercel.app). Click on the switch to toggle to "Seed". Enter your address and click `Get Seed`.

![result](/img/get-testnet-seed.png)

  </TabItem>
</Tabs>
