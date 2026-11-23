# Local Administrator GPO Deployment

**Author:** Nisar Muhammad  
**Copyright:** © 2026 Nisar Muhammad

**[Download the complete illustrated beginner PDF guide](Documentation/Local_Admin_GPO_Deployment_Step_by_Step_Guide.pdf?raw=true)**

**Isolated lab only.** Anyone with read access to a configured startup script can recover the plaintext password. Do not reuse a shared password across production computers. Use approved secure credential management in production.

**Compatibility:** This single-CMD example requires the original Windows WMIC utility and the English `Administrators` group. Windows 11 24H2 and later no longer provide WMIC on updated systems. The script stops before changing accounts if WMIC is unavailable. [Microsoft's WMIC removal notice](https://learn.microsoft.com/en-us/windows/whats-new/removed-features)

1. Copy `Deploy-LocalAdmin.cmd` outside Git. Edit **#CHANGE USERNAME** and **#CHANGE PASSWORD** in a private lab copy. The public template contains placeholders only.
2. Follow the [deployment guide](Documentation/Deployment-Guide.md) to validate the CMD on the lab client and configure Computer Startup. The CMD creates a missing account, enables an existing one without resetting its password, preserves the original expiration settings and ensures direct local Administrators membership.
3. Use the [fictional GPO example](Documentation/Example-GPO-Configuration.md), [troubleshooting](Documentation/Troubleshooting.md), and [security considerations](Documentation/Security-Considerations.md) for pilot checks and rollback.

[MIT license](LICENSE) · [Disclaimer & Limitation of Liability](DISCLAIMER.md) · [Changelog](CHANGELOG.md)

