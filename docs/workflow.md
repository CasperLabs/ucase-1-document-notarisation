```
# ---------------------------------------------------------------------------
# Step 0: Spinup network.
# ---------------------------------------------------------------------------

# Step 0.1: Launch local network.
nctl-assets-setup && nctl-start

# Step 0.2: Await for network to spinup.
nctl-view-chain-state-root-hash 

# Step 0.3: Display system account information - note defaults.
aibc-2021-view-account-A
aibc-2021-view-account-B
aibc-2021-view-account-C
aibc-2021-view-account-D

# ---------------------------------------------------------------------------
# Step 01: Install kv-storage.wasm contract.
# ---------------------------------------------------------------------------

# Step 01.1: Install kv-storage.wasm contract.
aibc-2021-step-01-set-contract

# Step 01.2: Display system account information - note updated named keys.
aibc-2021-view-account-A

# Step 01.3: Set contract hash for later - note see database.
aibc-2021-step-01-set-contract-hash

# ---------------------------------------------------------------------------
# Step 02: Set associated keys.
# ---------------------------------------------------------------------------

# Step 02.1: Set system account key weights.
aibc-2021-step-02-set-associated-keys

# Step 02.2: Display system account information - note updated key weights.
aibc-2021-view-account-A

# ---------------------------------------------------------------------------
# Step 03: Set action thresholds.
# ---------------------------------------------------------------------------

# Step 03.1: Set system account action thresholds.
aibc-2021-step-03-set-action-thresholds

# Step 03.2: Display system account information - note updated action thresholds.
aibc-2021-view-account-A

# ---------------------------------------------------------------------------
# Step 04: Set document checksum + metadata.
# ---------------------------------------------------------------------------

# Step 04.1: Display test document.
aibc-2021-step-04-view-document

# Step 04.2: Set document checksum.
aibc-2021-step-04-set-document-checksum

# Step 04.3: Set document metadata.
aibc-2021-step-04-set-document-metadata

# ---------------------------------------------------------------------------
# Step 05: Set deploy with multiple-signatures.
# ---------------------------------------------------------------------------

# Step 05.1: Set deploy 1 - display file deploy-1.json with user 1 approval: weight = 5.
aibc-2021-step-05-set-deploy-1

# Step 05.2: Set deploy 2 - display file deploy-2.json with user 2 approval: weight = 15.
aibc-2021-step-05-set-deploy-2

# Step 05.3: Set deploy 3 - display file deploy-3.json with user 3 approval: weight = 30.
aibc-2021-step-05-set-deploy-3

# Step 05.4: Dispatch deploy
# OPEN T3
aibc-2021-step-05-dispatch-deploy

# ---------------------------------------------------------------------------
# Step 06: Verify on-chain metadata.
# ---------------------------------------------------------------------------

# Step 06.1: View document metadata & verify.
aibc-2021-step-06-verify
```