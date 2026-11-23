# Fictional lab GPO example

| Setting | Example |
| --- | --- |
| Domain | corp.example.com |
| GPO | Local Administrator GPO Deployment |
| Computer OU | Pilot Computers |
| Computer | PILOT-01 |
| Custom local account | LocalSupportAdmin |
| Required platform | Isolated Windows client with WMIC and the English Administrators group |
| Trigger | Computer Configuration > Policies > Windows Settings > Scripts (Startup/Shutdown) > Startup |
| Scripts tab entry | Deploy-LocalAdmin.cmd |
| Script parameters | Empty |
| Distributed files | One configured CMD |

Create the GPO unlinked. Use **Show Files** to place the single CMD in the Startup folder, then **Link an Existing GPO** on the lab Pilot OU. Confirm replication and restart one scoped computer. Keep the plaintext configured copy outside Git.

[Microsoft Startup Scripts policy path](https://learn.microsoft.com/en-us/windows/client-management/mdm/policy-csp-admx-scripts)

