---
sidebar_position: 2
---

# Smart Contract

## Introduction

This exercise will guide you through building a **Voting dApp** designed to simulate the experience of actively participating in Decentralized Autonomous Organizations **(DAOs)** governance. As a member, you'll gain hands-on experience with the entire process: Create Proposals, View Proposals, Vote on Proposals.

## Voting dApp Backend Overview

Here are the backend functionalities that we will be implementing as shown below:

<p align="center">

```mermaid
flowchart LR
    Voting_dApp --> Initialise_DAO_Smart_Contract
    Voting_dApp --> Join_A_DAO
    Voting_dApp --> Create_A_Proposal
    Voting_dApp --> Vote_on_a_Proposal
    Voting_dApp --> Get_all_Proposals
```

</p>

<p align="center">Preview of Voting Smart Contract Functionalities</p>

The first step involves **Initializing the voting smart contract**! This initialization process is essential to allow users to interact with the smart contract.

With the smart contract initialized, users will then be able to engage with the **JoinDAO** function of the smart contract to become official members of the DAO.

As official members of the DAO, users will then be empowered to:

- **Create Proposals** where members can put forward their ideas and suggestions for the betterment of the DAO
- **View Proposals** where members are able to view the list of all proposals along with their current statuses
- **Vote on Proposals** where members are able to cast their votes on various proposals influencing the direction and decisions of the DAO!

Now that you have a better understanding of the functionalities of the Voting dApp that you will be building, we are now ready to set up the project!
