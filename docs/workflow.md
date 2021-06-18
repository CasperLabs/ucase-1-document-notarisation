```
# ---------------------------------------------------------------------------
# Step 0: Spinup network.
# ---------------------------------------------------------------------------

# Step 0.1: Launch local network.
nctl-assets-setup && nctl-start

# Step 0.2: Await for network to spinup.
nctl-view-chain-state-root-hash

# Step 0.3: Display accounts.
ucase-1-view-accounts

# ---------------------------------------------------------------------------
# Step 01: Set document checksum + metadata.
# ---------------------------------------------------------------------------

# Step 01.1: Set document checksum.
ucase-1-step-1-set-document-checksum

# Step 01.2: Set document metadata.
ucase-1-step-1-set-document-metadata

# ---------------------------------------------------------------------------
# Step 02: Set associated keys / action thresholds.
# ---------------------------------------------------------------------------

# Step 02.1: Set system account key weights - wait until pending deploys = 0.
ucase-1-step-2-set-key-weights

# Step 02.2: Set system account action thresholds - wait until pending deploys = 0.
ucase-1-step-2-set-action-thresholds

# Step 02.3: Display system account information - note updated key weights.
ucase-1-view-account-a

# ---------------------------------------------------------------------------
# Step 03: Install kv_storage.wasm contract.
# ---------------------------------------------------------------------------

# Step 03.1: Install kv_storage.wasm contract - wait until pending deploys = 0.
ucase-1-step-3-set-contract

# Step 03.2: Set contract hash memo.
ucase-1-step-3-set-contract-hash

# Step 03.3: Display system account information - note updated named keys.
ucase-1-view-account-a

# Step 03.4: Display contract information - note empty named keys.
ucase-1-view-contract-state

# ---------------------------------------------------------------------------
# Step 04: Set notarisations with multiple-signatures.
# ---------------------------------------------------------------------------

# Step 04.1: Set notarisation 1 - display file notarisation-1.json with user 1 approval: weight = 5.
ucase-1-step-4-set-notarisation-1
ucase-1-view-notarisation-1

# Step 04.2: Set notarisation 2 - display file notarisation-2.json with user 2 approval: weight = 15.
ucase-1-step-4-set-notarisation-2
ucase-1-view-notarisation-2

# Step 04.3: Set notarisation 3 - display file notarisation-3.json with user 3 approval: weight = 30.
ucase-1-step-4-set-notarisation-3
ucase-1-view-notarisation-3

# ---------------------------------------------------------------------------
# Step 05: Dispatch notarisation to chain.
# ---------------------------------------------------------------------------

# Step 05.1: Dispatch notarisation.
ucase-1-step-5-dispatch-notarisation-1

# ---------------------------------------------------------------------------
# Step 06: Verify on-chain metadata.
# ---------------------------------------------------------------------------

# Step 06.1: Display contract information - note named keys.
ucase-1-view-contract-state | jq '.result.stored_value.Contract.named_keys'

# Step 06.2: View document metadata & verify.
ucase-1-step-6-verify-metadata
```