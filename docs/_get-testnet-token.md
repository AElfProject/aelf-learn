To deploy smart contracts or execute on-chain transactions on AELF, you'll require testnet ELF tokens.

**Get ELF Tokens**

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

<Tabs>
  <TabItem value="cli" label="CLI" default>

Run this command to get testnet ELF token from faucet.

```bash
curl --location 'https://faucet.aelf.dev/api/claim' \
--header 'Content-Type: application/json' \
--data '{"walletAddress": $WALLET_ADDRESS}'
```

  </TabItem>
  <TabItem value="web" label="Web" default>

Go to this url [https://faucet-ui-preview.vercel.app](https://faucet-ui-preview.vercel.app). Enter your address and click `Get Tokens`.

![result](/img/get-token-ui.png)

  </TabItem>
</Tabs>
