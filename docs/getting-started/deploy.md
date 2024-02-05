---
sidebar_position: 10
---

# Deploy the smart contract

## Using GitHub Actions

A sample GitHub Actions [workflow](https://github.com/yongenaelf/aelf-devcontainer-template/blob/main/.github/workflows/main.yml) has been included in the template.

### Configuration

To use the workflow, ensure that you have [configured](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions#creating-secrets-for-a-repository) the following repository secrets in your GitHub repository:

1. PRIVATEKEY: The private key of your wallet
2. WALLET_ADDRESS: The address of the wallet

![repository secrets](/img/repository-secrets.png)

To generate a private key and wallet address, use `aelf-command`:

```bash
aelf-command create
```

### Triggering the workflow

The workflow is triggered whenever a new tag is pushed:

```bash
git tag v1.0.0
git push --tags
```

Refer to [Events that trigger workflows](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows) for more information on how to customise this.

### View details of the deployment

To view details of a deployment, click on the Actions tab in the GitHub UI, then click on the workflow you wish to view.

Under the Summary, you can view details of the contract:

| Item                                    | Description                                          |
| --------------------------------------- | ---------------------------------------------------- |
| transactionId                           | The id of the transaction `DeployUserSmartContract`. |
| proposalId                              | The id of the proposal.                              |
| View proposal on AElf Explorer          | Link to view the proposal on AElf Explorer.          |
| isContractDeployed                      | Whether the contract has been deployed.              |
| status                                  | The status of the proposal.                          |
| Deployed Contract Address               | The address of the deployed contract.                |
| View deployed contract on AElf Explorer | Link to view the contract on AElf Explorer.          |

![github actions deploy summary](/img/github-actions-deploy-summary.png)

### Error handling

Sometimes one of the build steps fails, to retry, click on the refresh button next to the failed step, then click on "Re-run jobs":

![proposal action failed](/img/proposal-action-failed.png)

If the step continues to fail, view the logs to determine the cause of the issue, and the steps to resolve it.
