Acquire testnet tokens for covering transaction fees essential for contract deployment.

**Get ELF Tokens**

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

<Tabs>
  <TabItem value="cli" label="CLI" default>

Run this command to get token from faucet.

```
curl --location 'https://faucet.aelf.dev/api/claim' \
--header 'Content-Type: application/json' \
--data '{"walletAddress": "Your wallet address"}'
```

  </TabItem>
  <TabItem value="web" label="Web" default>

Go to this url [https://faucet-ui-preview.vercel.app](https://faucet-ui-preview.vercel.app). Enter your address and click `Get Tokens`.

![result](/img/get-token-ui.png)

  </TabItem>
</Tabs>
