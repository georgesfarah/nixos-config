# Applying the config

Before running `home-manager switch`, check `home.username` and `home.homeDirectory` in `home.nix`:

- If they already match the current user and machine, apply directly.
- If they don't match, read `README.md` for the correct apply command, and temporarily update those two fields to match the current user before switching. Revert them afterwards — do not commit the change.
