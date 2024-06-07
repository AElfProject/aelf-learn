To acquire testnet Token type SEED for creating fungible or non-fungible tokens on aelf testnet.

**Get Token Type Seed Token**

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

<Tabs>
  <TabItem value="cli" label="CLI" default>

Run the following command to get testnet SEED token from faucet. Remember to either export your wallet address or replace $WALLET_ADDRESS with your wallet address.

```bash title="Terminal"
curl -X POST "https://faucet.aelf.dev/api/claim-seed?walletAddress=$WALLET_ADDRESS" -H "accept: application/json" -d ""
```

  </TabItem>
  <TabItem value="web" label="Web" default>

Go to this url [https://faucet-ui-preview.vercel.app](https://faucet-ui-preview.vercel.app). Click on the dropdown to select "Token Seed". Enter your address and click `Get Seed`.

![result](/img/get-testnet-token-seed.png)

  </TabItem>
</Tabs>
