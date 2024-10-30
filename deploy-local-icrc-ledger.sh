#!/bin/bash

# Set up the environment
dfx start --background

# Create canisters
echo "Creating canisters..."
dfx canister create icrc1_ledger_canister

# Build the canisters
echo "Building canisters..."
dfx build

# Install the canisters
echo "Installing canisters..."
dfx canister install icrc1_ledger_canister

echo "Deployment complete!"
