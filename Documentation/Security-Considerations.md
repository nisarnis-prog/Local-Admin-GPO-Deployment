# Security considerations

**This is a legacy demonstration for an isolated lab.** Anyone who can read the configured CMD can recover its password. The account-creation command may expose the password in process telemetry even when console output is suppressed.

- Never publish or commit a configured copy. Keep the lab file outside Git.
- Never use the same administrator password across production computers. Use approved secure per-device credential management and rotation in production.
- The original settings disable account and password expiration and stop the account holder from changing the password. Without a separate rotation process the password can remain valid indefinitely.
- Use the lab GPO Startup folder and preserve standard GPO permissions. For an approved lab SMB alternative, grant the scoped computer identities share Read and NTFS Read & Execute. Allow writes only by delegated maintainers. A hidden share does not protect a credential.
- The script targets one local custom account. An error after creation or enablement can leave partial changes. Review and roll back only the intended account.
- WMIC is a legacy Windows utility. The script stops when it is unavailable. [Microsoft WMIC removal notice](https://learn.microsoft.com/en-us/windows/whats-new/removed-features)

