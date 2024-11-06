#!/usr/bin/env bash  # Shebang line to specify the script should be run in the Bash shell

# Change the variable to "ic" to deploy the ledger on the mainnet.
export NETWORK=local  # Set the network to local for deployment

# Create a new identity named 'minter' with plaintext storage mode
dfx identity new minter --storage-mode=plaintext

# Switch to the minter identity to perform actions as this user
dfx identity use minter 

# Get the account ID for the minter identity and store it in a variable
export MINTER_ACCOUNT_ID=$(dfx ledger account-id)

# Switch back to the default identity
dfx identity use default 

# Get the account ID for the default identity and store it in a variable
export DEFAULT_ACCOUNT_ID=$(dfx ledger account-id)

# Switch back to the minter identity again
dfx identity use minter 

# Deploy the ledger canister with specified settings
dfx deploy --specified-id ryjl3-tyaaa-aaaaa-aaaba-cai ledger_canister --argument '(variant {
    Init = record {
      minting_account = "'${MINTER_ACCOUNT_ID}'";  # Specify the minting account
      initial_values = vec {  # Set initial values for the ledger
        record {
          "'${DEFAULT_ACCOUNT_ID}'";  # The account that receives initial tokens
          record {
            e8s = 1000_000_000_000 : nat64;  # Amount of tokens (in e8s)
          };
        };
      };
      send_whitelist = vec {};  # No send whitelist for transfers
      transfer_fee = opt record {  # Set a transfer fee
        e8s = 10_000 : nat64;  # Amount of the transfer fee (in e8s)
      };
      token_symbol = opt "LICP";  # Set the token symbol
      token_name = opt "Local ICP";  # Set the token name
    }
  })'
