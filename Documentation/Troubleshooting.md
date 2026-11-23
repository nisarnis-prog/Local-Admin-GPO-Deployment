# Troubleshooting

| Symptom | Check |
| --- | --- |
| Invalid lab configuration | Replace both placeholders and use the documented length and character rules. Do not disclose the configured password. |
| WMIC unavailable | The CMD stops before changing accounts. Updated Windows 11 24H2 and later removed WMIC. Use an existing compatible isolated lab image for this legacy demonstration. |
| Platform or group check fails | Confirm the target is a Windows lab client and the local group is named Administrators in English. Use a custom local account. |
| Create or enable fails | Check elevation, account name and local password policy. A failed lookup can reach the create branch, but the add-only command cannot reset an existing password. |
| Expiration or membership fails | Inspect the target, since earlier changes may have succeeded. Run the read-only checks in the deployment guide. |
| No startup result | Check GPO scope and permissions, presence of the one CMD in the Startup folder, replication, lab boot connectivity, and GroupPolicy Operational events. |

Exit 0 means the commands completed and password non-expiration and direct membership were verified. Exit 1 indicates a detected failure. Repeat runs reapply the account settings without a password reset and skip expiration and membership writes if already verified.

[Deployment and rollback](Deployment-Guide.md)

