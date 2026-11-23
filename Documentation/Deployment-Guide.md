# Deployment guide

## 1. Configure a private lab copy

Open `Deploy-LocalAdmin.cmd` in Notepad. Replace `CHANGE_USERNAME` under **#CHANGE USERNAME** and `CHANGE_PASSWORD` under **#CHANGE PASSWORD**. Keep the quotes and save. Use a dedicated custom local account. The username must start with an ASCII letter and use 1 to 20 ASCII letters, digits, underscores, or hyphens. The password must contain 12 to 127 characters, start with an ASCII letter or digit, and use only ASCII letters, digits, or `_ @ + = . , : # -`. Windows policy may impose additional rules. Keep the configured file outside Git.

## 2. Preflight the lab client

Use an isolated domain-joined Windows client with WMIC already available and the English `Administrators` group. Check `wmic os get ProductType /value` for `ProductType=1`, and `net localgroup Administrators` for a readable group. Updated Windows 11 24H2 and later lack WMIC. Keep a tested recovery administrator. Record whether the target already exists, its SID, enablement, account and password expiration, password-change rights, and direct membership. Run the CMD elevated on only the isolated lab client to validate the behavior.

## 3. Configure Computer Startup

Create an unlinked GPO in GPMC. Edit **Computer Configuration > Policies > Windows Settings > Scripts (Startup/Shutdown) > Startup**. On the **Scripts** tab, use **Show Files** to place the single configured CMD in the lab Startup folder. Choose **Add**, select `Deploy-LocalAdmin.cmd`, leave parameters empty, and save. Respect standard GPO file permissions and restrict edit access.

## 4. Link and verify

Link the GPO to the lab **Pilot Computers** OU with one test computer object. Confirm computer Read and Apply Group Policy, allow replication, then restart with lab domain connectivity. A refresh or user sign-in alone does not run Computer Startup.

Check `gpresult /scope computer /r` and the GroupPolicy Operational log. Use `net user LocalSupportAdmin` to confirm enabled, no account or password expiration, and no password changes by the account holder. Use `net localgroup Administrators` to confirm direct membership. Compare the target SID across two boots using `wmic useraccount where "LocalAccount=True And Name='LocalSupportAdmin'" get SID /value`. The enable branch does not reset the password.

## 5. Roll back

Disable or unlink the pilot GPO and verify it no longer applies. On an existing account, restore the recorded state, expiration, password-change rights, and direct membership for that SID. For a newly created lab account, remove or disable only that account after verifying recovery access. Remove the configured file from lab distribution and rotate exposed credentials. Unlinking alone does not undo changes.

