# Local Administrator GPO Deployment

**Author:** Nisar Muhammad  
**Copyright:** © 2026 Nisar Muhammad

**[Download the complete illustrated beginner PDF guide](Documentation/Local_Admin_GPO_Deployment_Step_by_Step_Guide.pdf?raw=true)**

**Isolated lab only.** Anyone with read access to a configured startup script can recover the plaintext password. Do not reuse a shared password across production computers. Use approved secure credential management in production.

**Compatibility:** This single-CMD example requires the original Windows WMIC utility and the English `Administrators` group. Windows 11 24H2 and later no longer provide WMIC on updated systems. The script stops before changing accounts if WMIC is unavailable. [Microsoft's WMIC removal notice](https://learn.microsoft.com/en-us/windows/whats-new/removed-features)

1. Copy `Deploy-LocalAdmin.cmd` outside Git. Edit **#CHANGE USERNAME** and **#CHANGE PASSWORD** in a private lab copy. The public template contains placeholders only.
2. Follow the [deployment guide](Documentation/Deployment-Guide.md) to validate the CMD on the lab client and configure Computer Startup. The CMD creates a missing account, enables an existing one without resetting its password, preserves the original expiration settings and ensures direct local Administrators membership.
3. Use the [fictional GPO example](Documentation/Example-GPO-Configuration.md), [troubleshooting](Documentation/Troubleshooting.md), and [security considerations](Documentation/Security-Considerations.md) for pilot checks and rollback.

[Changelog](CHANGELOG.md)

## License

This project is licensed under the [MIT License](LICENSE).

Copyright (c) 2026 Nisar Muhammad.

You may use, modify, and redistribute this educational CMD example and its documentation under the MIT License. The software is provided AS IS without warranty. It is intended for isolated lab evaluation only and has not been validated for production deployment.

## Safety, user responsibilities and liability

- Verify the target Windows client, local account identity, GPO scope, computer OU, administrator group name, WMIC availability, permissions, and startup-script configuration before testing. Incorrect configuration may create or change privileged accounts.
- Protect configured passwords and startup scripts. A plaintext password in a CMD or GPO Startup folder can be exposed to anyone with read access; never publish a configured copy or reuse the same administrator password across production computers. Use Windows LAPS or approved per-device credential management for production.
- Test independently on an isolated lab computer with a working recovery administrator. Live CMD and GPO execution have not been validated for this release. Failures can leave partial account or group changes; unlinking a GPO does not automatically reverse them.
- Administrators are responsible for authorization, secure credential handling, recoverable backups, validation, rollback, operational security, and compliance with applicable organizational and regulatory requirements.

The software and documentation are provided as is under the [MIT License](LICENSE), without warranty. The author does not guarantee successful deployment, compatibility, security, or uninterrupted operation. To the extent permitted by applicable law, the author is not liable for losses or damage arising from use. See the [Disclaimer & Limitation of Liability](DISCLAIMER.md) and [security considerations](Documentation/Security-Considerations.md).
