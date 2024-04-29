---
sidebar_position: 1
---
# Environment setup

The easiest way to get started is to use this repository template: https://github.com/yongenaelf/aelf-devcontainer-template.

Click on the `Use this template` button and choose `Create a new repository`.

Type a suitable repository name and click `Create repository`.

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

<Tabs>
  <TabItem value="codespaces" label="GitHub Codespaces" default>

Within the GitHub interface, click on `Code`, then choose `Codespaces`.

Click on the plus "+" sign to create a new Codespace.

After a moment, your workspace will load with the contents of the repository, and you will be able to continue your development using GitHub Codespaces.

![codespaces](/img/codespaces.png)

</TabItem>
  <TabItem value="local" label="Local development">

Clone your repository to your local working directory.

# Install required software

To use the template locally, install the following:

- [Docker](https://www.docker.com/get-started/)
- [VS Code](https://code.visualstudio.com/)

# Start Docker

Ensure that Docker is running (if not, start Docker).

# Open project folder in VS Code

Open the project folder in VS Code.

Next, press `F1` and enter `reopen`, then choose `Dev Containers: Reopen in Container`.

Wait while the environment loads.
</TabItem>
</Tabs>


